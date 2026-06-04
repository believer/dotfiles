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

(setq display-line-numbers-type 'relative)

(after! evil
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate)))

(setq
 evil-split-window-below t
 evil-vsplit-window-right t)

;; Skip confirm to exit message
(setq confirm-kill-emacs nil)

;; Move files to trash when deleting in dired
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash")

;; Tell projectile to also look for package.json
(after! projectile
  (add-to-list 'projectile-project-root-files-bottom-up "package.json"))

;; Use projectile to run commands
(defun my/run-command (command)
  "Run COMMAND in a compilation buffer with live output."
  (let* ((default-directory (projectile-project-root))
         (buf (compilation-start command 'compilation-mode
                                 (lambda (_) (concat "*" command "*")))))
    ;; Focus new buffer
    (pop-to-buffer buf)))

(defun my/yarn-typecheck ()
  "Run type check"
  (interactive)
  (my/run-command "yarn typecheck"))

(defun my/yarn-test ()
  "Run affected tests"
  (interactive)
  (my/run-command "yarn test -o"))

;; This runs in async mode in the background
(defun my/yarn-dev-server ()
  "Run React Native Dev Server"
  (interactive)
  (let ((name "*rn-dev-server*"))
    (if (get-buffer-process name)
        (pop-to-buffer name)
      ;; Start server
      (projectile-run-async-shell-command-in-root "yarn start --reset-cache" name)
      ;; Focus buffer
      (pop-to-buffer name)
      ;; Hide buffer after three seconds
      (run-with-timer 3 nil #'delete-windows-on (get-buffer name)))))

;; Key maps for dev commands
(map! :leader
      :prefix "d"
      :desc "Yarn dev server" "s" #'my/yarn-dev-server
      :desc "Yarn typecheck" "y" #'my/yarn-typecheck
      :desc "Yarn test (only changed)" "t" #'my/yarn-test)

(after! dirvish
  (setq dirvish-hide-details t))

;; Disable diredfl since it overrides colors from theme
(after! diredfl
  (remove-hook 'dired-mode-hook #'diredfl-mode))

;; Open dired more like Oil.nvim
(map! :nv "-" #'dired-jump)

;; Calendars start on Monday
(setq calendar-week-start-day 1)

;; Org mode directories
(setq org-directory "~/.orgfiles/")
(setq org-agenda-files
      (list
       (expand-file-name "notes.org" org-directory)
       (expand-file-name "tasks.org" org-directory)
       (expand-file-name "journal" org-directory)
       (expand-file-name "projects" org-directory)))

;; Add a timestamp when a task is marked done
(setq org-log-done 'time)

;; Templates
(setq org-default-notes-file (concat org-directory "notes.org"))
(setq org-capture-templates
      `(("t" "Task" entry
         (file+headline ,(concat org-directory "tasks.org") "Tasks")
         "** TODO %?\n%^t\n%a\n")))

(setq
 org-journal-dir (concat org-directory "journal")
 org-journal-file-format  "%Y%m%d.org"
 org-journal-date-format "%A, %Y-%m-%d")

;; Automatically enable org-journal-mode for all files inside the journal folder
;; This makes it possible to use the key bindings below
(add-to-list 'auto-mode-alist
             (cons (concat (regexp-quote (expand-file-name org-journal-dir)) ".*\\.org\\'")
                   'org-journal-mode))

(map! :leader
      :prefix "o"
      :desc "New journal entry" "j e" #'org-journal-new-entry
      :desc "Next journal entry" "j n" #'org-journal-next-entry
      :desc "Previous journal entry" "j p" #'org-journal-previous-entry)

(use-package! denote
  :config
  (setq denote-directory (concat org-directory "notes"))
  (setq denote-directories
        (list (expand-file-name (concat org-directory "notes"))))
  (setq denote-dired-directories
        (list (expand-file-name (concat org-directory "notes"))))
  ;; This enables denote-dired-mode in notes, but I'm not seeing a difference
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories))

(map! :leader
      :prefix "n"
      :desc "New note"  "n" #'denote
      :desc "Link note" "l" #'denote-link)

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
  (evil-window-vsplit)
  (+lookup/definition (point)))

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

  ;; Register Templ LSP
  (lsp-register-client
    (make-lsp-client
    :new-connection (lsp-stdio-connection '("templ" "lsp"))
    :major-modes '(templ-ts-mode)
    :server-id 'templ
    ;; Same as above for gopls and templ
    :add-on? t))

  ;; Only allow these clients
  (setq lsp-enabled-clients '(biome ts-ls templ gopls)))

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
