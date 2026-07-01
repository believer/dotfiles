;; -*- lexical-binding: t; -*-

(defun my/tangle-config ()
  ;; file-equal-p resolves symlinks
  (when (file-equal-p (buffer-file-name)
                      (expand-file-name "config.org" doom-user-dir))
    (org-babel-tangle)))

(add-hook 'after-save-hook #'my/tangle-config)

(map! :leader
      :desc "Pull from origin"
      "g u" #'(lambda ()
                (interactive)
                (magit-pull-from-upstream nil))
      :desc "Push to current branch"
      "g p" #'(lambda ()
                (interactive)
                (magit-push-current-to-upstream nil)))

(setq doom-font (font-spec :family "MonoLisa" :size 12))

(setq tokyo-night-scale-headings nil)
(setq doom-theme 'tokyo-night)

;; Get color output in compilation windows
(setenv "FORCE_COLOR" "1")

(setq display-line-numbers-type 'relative)

(after! evil
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate)))

(setq
 evil-split-window-below t
 evil-vsplit-window-right t)

(map! :leader
      :prefix "o"
      :desc "Toggle Olivetti mode" "l" #'olivetti-mode)

(use-package doom-modeline-now-playing
  :after doom-modeline
  :config
  (doom-modeline-now-playing-timer))

(with-eval-after-load 'doom-modeline-now-playing
  (doom-modeline-def-segment my-separator
    (propertize " | " 'face 'doom-modeline))
  (doom-modeline-def-modeline 'main
    '(bar workspace-name window-number matches buffer-info)
    '(now-playing my-separator lsp minor-modes major-mode vcs)))

;; Longer names
(setq doom-modeline-now-playing-max-length 60)

;; Skip confirm to exit message
(setq confirm-kill-emacs nil)

;; Move files to trash when deleting in dired
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash")

(defun my/find-related-test-file ()
  "Return the path of the test file related to the current buffer or nil if not found"
    (let* ((current-file (buffer-file-name))
         (file-name (file-name-nondirectory current-file))
         (dir (file-name-directory current-file))
         (base (file-name-sans-extension file-name)))
      (if (string-match-p "\\.spec\\.tsx?$" file-name)
          current-file
        (cl-find-if #'file-exists-p
                    (list (concat dir base ".spec.ts")
                           (concat dir base ".spec.tsx")
                           (concat dir "__tests__/" base ".spec.ts")
                           (concat dir "__tests__/" base ".spec.tsx"))))))

(defun my/open-related-test-file ()
  "Open a test file related to the current buffer. Looks for a .spec.ts/tsx file that's
either co-located or in a __tests__ subdirectory. If in a test file, open related code file."
  (interactive)
  (if (string-match-p "\\.spec\\.tsx?$" (buffer-file-name))
      (let* ((current-file (buffer-file-name))
             (base (replace-regexp-in-string "\\.spec\\(\\.tsx?\\)$" "\\1" current-file))
             (candidates (list base
                               (replace-regexp-in-string "/__tests__/" "/" base))))
        (if-let ((found (seq-find #'file-exists-p candidates)))
            (progn
              (evil-window-vsplit)
              (windmove-left)
              (find-file found))
          (message "No related source file found for %s" (file-name-nondirectory current-file))))
    (let* ((current-file (buffer-file-name))
         (file-name (file-name-nondirectory current-file))
         (ext (file-name-extension current-file))
         (dir (file-name-directory current-file))
         (base (file-name-sans-extension file-name))
         (found (my/find-related-test-file)))
    (if found
        (progn
          (evil-window-vsplit)
          (find-file found))
      (when (yes-or-no-p (format "No tests found for %s. Create one? " file-name))
        (evil-window-vsplit)
        (find-file (concat dir base ".spec." ext)))))))

(defun my/run-related-tests ()
  "Run tests related to current buffer"
  (interactive)
  (let* ((current-file (buffer-file-name))
         (file-name (file-name-nondirectory current-file))
         (test-file (my/find-related-test-file)))
    (if test-file
        (compilation-start (concat "yarn test " test-file) 'compilation-mode
                           (lambda (_) (concat "*yarn test " test-file "*")))
      (message "No test file found for %s" file-name))))

;; Tell projectile to also look for package.json
(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "package.json"))

;; Use projectile to run commands
(defun my/run-command (buf-name command)
  "Run COMMAND in a compilation buffer with live output."
  (let ((default-directory (projectile-project-root)))
    (compilation-start command 'compilation-mode
                       (lambda (_) (concat "*" buf-name "*")))))

(defun my/yarn-typecheck ()
  "Run type check"
  (interactive)
  (my/run-command "typecheck" "yarn typecheck"))

(defun my/yarn-test-affected ()
  "Run affected tests"
  (interactive)
  (my/run-command "test:affected" "yarn test -o"))

(defun my/knip ()
  "Run knip"
  (interactive)
  (my/run-command "knip" "yarn knip"))

(defun my/run-in-vterm-sidebar (buf-name command)
  (let* ((buf (get-buffer buf-name))
         (root (projectile-project-root)))
    (cond
      ((and buf (get-buffer-window buf))
       (delete-window (get-buffer-window buf)))
      (buf (pop-to-buffer buf))
      (t (set-popup-rule! buf-name :side 'right :width 0.4 :quit nil :ttl nil)
         (vterm buf-name)
         (run-with-timer 0.3 nil
           (lambda ()
             (with-current-buffer buf-name
               (process-send-string
                (get-buffer-process (current-buffer))
                (format "cd %s && %s\n" root command)))))))))

(defun my/test-watch ()
  (interactive)
  (my/run-in-vterm-sidebar "*test:watch*" "yarn test --watch"))

(defun my/typecheck-watch ()
  (interactive)
  (my/run-in-vterm-sidebar "*typecheck:watch*" "yarn typecheck --watch"))

;; This runs in async mode in the background
(defun my/yarn-dev-server ()
  "Run React Native Dev Server"
  (interactive)
  (let ((name "*rn-dev-server*"))
    (if (get-buffer-process name)
        (pop-to-buffer name)
      ;; Start server
      (projectile-run-async-shell-command-in-root "yarn start --reset-cache" name)
      ;; Hide buffer after three seconds
      (run-with-timer 3 nil #'delete-windows-on (get-buffer name)))))

;; Compilation buffers to auto-close on success.
(defvar my/auto-close-compilation-buffers
  '("*typecheck*" "*test:affected*" "*knip*"))

(defun my/close-compilation-buffer-if-successful (buffer string)
  "Close compilation buffer automatically if it was successful"
  (when (and (string-match "finished" string)
             (not (string-match "warning" string))
             (member (buffer-name buffer) my/auto-close-compilation-buffers))
    (run-with-timer 1.5 nil #'kill-buffer buffer)))

(add-hook 'compilation-finish-functions #'my/close-compilation-buffer-if-successful)

;; Key maps for dev commands
(map! :leader
      :prefix "t"
      :desc "Yarn test (affected)" "a" #'my/yarn-test-affected
      :desc "Yarn typecheck" "C" #'my/yarn-typecheck
      :desc "Yarn typecheck (watch)" "c" #'my/typecheck-watch
      :desc "Run file tests" "f" #'my/run-related-tests
      :desc "Knip" "k" #'my/knip
      :desc "Yarn dev server" "s" #'my/yarn-dev-server
      :desc "Open related test file in vsplit" "t" #'my/open-related-test-file
      :desc "Run tests (watch)" "w" #'my/test-watch)

(after! dirvish
  (setq dirvish-hide-details t))

;; Open dired more like Oil.nvim
(map! :nv "-" #'dired-jump)

(map! :leader
      :prefix "d"
      :desc "List flycheck errors" "e" #'flycheck-list-errors)

;; Calendars start on Monday
(setq calendar-week-start-day 1)

;; Org mode directories
(setq org-directory "~/.orgfiles/")
(setq org-agenda-files
      (list
       (expand-file-name "notes.org" org-directory)
       (expand-file-name "tasks.org" org-directory)
       (expand-file-name "projects.org" org-directory)
       (expand-file-name "todo.org" org-directory)
       (expand-file-name "journal" org-directory)
       (expand-file-name "projects" org-directory)))

;; Add a timestamp when a task is marked done
(setq org-log-done 'time)

;; Templates
(setq org-default-notes-file (concat org-directory "notes.org"))

(setq org-roam-directory (concat org-directory "notes"))
(org-roam-db-autosync-mode)

(setq user-full-name "Rickard Natt och Dag")

;; Go
(add-hook 'go-ts-mode-hook
          (lambda ()
            (setq tab-width 2)
            (local-set-key (kbd "TAB") #'tab-to-tab-stop)))

;; Setup auto adding of language modes
(dolist (mapping '(("\\.ts\\'" . typescript-ts-mode)
                   ("\\.tsx\\'" . tsx-ts-mode)
                   ("\\.templ\\'" . templ-ts-mode)))
  (add-to-list 'auto-mode-alist mapping))

(defun my/lookup-definition-vsplit ()
  "Go to definition in new vertical split"
  (interactive)
  (let ((sym (thing-at-point 'symbol t)))
    (evil-window-vsplit)
    (+lookup/definition sym)))

(map! :n "g V" #'my/lookup-definition-vsplit)

(defun my/biome-find-root (file-name)
  "Walk up from FILE-NAME to find the nearest biome.json/biome.jsonc directory."
  (locate-dominating-file file-name
    (lambda (dir)
      (or (file-exists-p (expand-file-name "biome.json" dir))
          (file-exists-p (expand-file-name "biome.jsonc" dir))))))

(defun my/biome-project-root ()
  "Return the nearest biome.json directory for the current buffer, or nil."
  (when-let* ((buf-file (buffer-file-name)))
    (my/biome-find-root buf-file)))

(after! lsp-mode
  ;; Map treesitter modes to LSP language IDs
  (dolist (id-config '((typescript-ts-mode . "typescript")
                     (tsx-ts-mode . "typescriptreact")
                     (templ-ts-mode . "templ")))
    (add-to-list 'lsp-language-id-configuration id-config))

  ;; Setup preferences for TypeScript
  (setq lsp-clients-typescript-preferences
        '(:includeCompletionsForModuleExports t
          :includeCompletionsForImportStatements t
          :importModuleSpecifierPreference "non-relative"
          :importModuleSpecifierEnding "minimal"))

  ;; Register Biome as an add-on LSP server (runs alongside ts-ls)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection
                     (lambda ()
                       ;; Prefer the local node_modules/.bin/biome over the global one,
                       ;; mirroring what nvim-lspconfig does
                       (let* ((root (my/biome-project-root))
                              (local-bin (and root
                                              (expand-file-name "node_modules/.bin/biome" root))))
                         (if (and local-bin (file-executable-p local-bin))
                             (list local-bin "lsp-proxy")
                           '("biome" "lsp-proxy")))))
      :activation-fn (lambda (file-name _mode)
                       ;; Only activate when the project actually uses Biome and file extensions match
                       (and (string-match-p "\\.\\(ts\\|tsx\\|js\\|jsx\\|json\\)\\'" file-name)
                            (my/biome-find-root file-name)
                            t))
    :multi-root nil
    :server-id 'biome
    ;; This is needed to run ts_ls and biome together
    :add-on? t))

  ;; Templ
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection '("templ" "lsp"))
    :major-modes '(templ-ts-mode)
    :server-id 'templ
    :add-on? t))

  ;; Yaml schemas
  (let ((schemas (make-hash-table :test 'equal)))
    (puthash "https://raw.githubusercontent.com/nexlabstudio/maestro-workbench/refs/heads/dev/schema/schema.v0.json"
             ["/apps/blackbird/.maestro/**/*"]
             schemas)
    (puthash "https://json.schemastore.org/github-workflow.json"
             ["/.github/workflows/*"]
             schemas)
    (setq lsp-yaml-schemas schemas))

  ;; Only allow these clients
  ;; JSON and YAML LSPs come from built-in
  (setq lsp-enabled-clients '(biome ts-ls templ gopls json-ls yamlls))
  )

;; Start LSP in TreeSitter modes
(add-hook! '(typescript-ts-mode-hook
             tsx-ts-mode-hook
             go-ts-mode-hook
             templ-ts-mode-hook)
           #'lsp!)

;; Skip file watches to not get a warning in large projects
(setq lsp-enable-file-watchers nil)

;; Setup formatting through Apheleia
;; Commands are taken from conform.nvim.
(after! apheleia
  ;; Formatters
  (setf (alist-get 'biome apheleia-formatters) '("biome" "check" "--write" "--stdin-file-path" filepath) ; Using check --write also runs actions.
        (alist-get 'templ apheleia-formatters) '("templ" "fmt" "-stdin-filepath" filepath))

  ;; Biome
  (dolist (mode '(typescript-ts-mode tsx-ts-mode js-ts-mode json-ts-mode json-mode))
    (setf (alist-get mode apheleia-mode-alist) '(biome)))

  ;; Go and templ
  (setf (alist-get 'go-ts-mode apheleia-mode-alist) '(goimports)
        (alist-get 'templ-ts-mode apheleia-mode-alist) '(templ)))

(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all))

(require 'cl-lib)

(defun pascal-case-file-name ()
  "Return the current file name in PascalCase"
  (let* ((name (file-name-sans-extension (buffer-name)))
         (parts (split-string name "[-_]")))
    (mapconcat #'capitalize parts "")))

(defun pace-to-seconds (pace)
  "Convert running pace (min/km) to seconds"
  (let ((parts (mapcar 'string-to-number (split-string pace ":"))))
    (+ (* 60 (car parts)) (cadr parts))))

(defun pace-diff (target actual)
  "Return difference in seconds between two mm:ss pace strings.
Negative means faster than target, positive means slower."
  (when (and (stringp target) (string-match-p "^[0-9]" target))
    (- (pace-to-seconds actual)
       (pace-to-seconds target))))

(defun pace-diff-fmt (target actual)
  "Return formatted mm:ss difference between two pace strings.
Negative means faster than target, positive means slower."
  (let ((d (pace-diff target actual)))
    (when d
      (format "%s%d:%02d"
              (if (< d 0) "-" "+")
              (/ (abs d) 60)
              (mod (abs d) 60)))))

(defun pace-distance-fmt (pace distance)
  "Return formatted time (x h x min) for a given pace (min/km) and distance"
  (let* ((pace-total-sec (pace-to-seconds pace))
         (total-sec (* pace-total-sec (string-to-number distance)))
         (hours (/ total-sec 3600))
         (minutes (/ (mod total-sec 3600) 60))
         (seconds (mod total-sec 60)))
    (mapconcat #'identity
               (seq-filter #'identity
                           (list (when (> hours 0)   (format "%d h" hours))
                                 (when (> minutes 0) (format "%d min" minutes))
                                 (when (> seconds 0) (format "%d sec" seconds))))
               " ")))
