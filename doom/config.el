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

;; Use rainbow brackets
(add-hook 'org-mode-hook #'rainbow-delimiters-mode)
(add-hook 'typescript-ts-mode-hook #'rainbow-delimiters-mode)

(setq display-line-numbers-type 'relative)

(after! evil
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate)))

;; Skip confirm to exit message
(setq confirm-kill-emacs nil)

;; Calendars start on Monday
(setq calendar-week-start-day 1)

;; Move files to trash when deleting in dired
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash")

(after! dirvish
  (setq dirvish-hide-details t))

;; Disable diredfl since it overrides colors from theme
(after! diredfl
  (remove-hook 'dired-mode-hook #'diredfl-mode))

;; Org mode directories
(setq org-directory "~/.orgfiles/")
(setq org-agenda-files
      (list
       (expand-file-name "notes.org" org-directory)
       (expand-file-name "tasks.org" org-directory)
       (expand-file-name "projects" org-directory)))

;; Add a timestamp when a task is marked done
(setq org-log-done 'time)

;; Templates
(setq org-default-notes-file (concat org-directory "notes.org"))
(setq org-capture-templates
      `(("t" "Task" entry
         (file+headline ,(concat org-directory "tasks.org") "Tasks")
         "* TODO %?\n%^t\n%a\n")))

(use-package! denote
  :config
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

(after! go-mode
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save))

;; Use TreeSitter modes for TypeScript/TSX files
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(after! lsp-mode
  ;; Map treesitter modes to LSP language IDs
  (add-to-list 'lsp-language-id-configuration '(typescript-ts-mode . "typescript"))
  (add-to-list 'lsp-language-id-configuration '(tsx-ts-mode . "typescriptreact"))

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
                       ;; Only activate when the project actually uses Biome
                       (and (my/biome-find-root file-name) t))
    :multi-root nil
    :server-id 'biome
    ;; This seemed to be essential to make it possible to run multiple LSPs
    :add-on? t))

  ;; Only allow these two clients
  (setq lsp-enabled-clients '(biome ts-ls)))

;; Start LSP in TreeSitter modes
(add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!)

;; Skip file watches to not get a warning in large projects
(setq lsp-enable-file-watchers nil)

;; Setup Biome formatting through Apheleia
(after! apheleia
  (setf (alist-get 'biome apheleia-formatters)
        ;; Command from conform.nvim. Using check --write also runs actions.
        '("biome" "check" "--write" "--stdin-file-path" filepath))
  (setf (alist-get 'tsx-ts-mode apheleia-mode-alist) '(biome))
  (setf (alist-get 'typescript-ts-mode apheleia-mode-alist) '(biome))
  (setf (alist-get 'js-ts-mode apheleia-mode-alist) '(biome))
  (setf (alist-get 'json-ts-mode apheleia-mode-alist) '(biome))
  (setf (alist-get 'json-mode apheleia-mode-alist) '(biome)))

(use-package! treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all))
