(defun my/tangle-config ()
  (when (string-equal (buffer-file-name)
                      (expand-file-name "config.org" doom-user-dir))
    (org-babel-tangle)))

(add-hook 'after-save-hook #'my/tangle-config)

(setq doom-font (font-spec :family "MonoLisa" :size 11))

(setq doom-theme 'doom-tokyo-night)

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

(setq org-directory "~/.orgfiles/")
(setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))

(setq org-log-done 'time)

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

  ;; Register Biome as an add-on LSP server (runs alongside ts-ls)
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection (lambda () '("biome" "lsp-proxy")))
    :activation-fn (lsp-activate-on "typescript" "typescriptreact" "javascript")
    :server-id 'biome
    :add-on? t))

  ;; Only allow these two clients
  (setq lsp-enabled-clients '(biome ts-ls))

  ;; Biome is the primary formatter for TS/TSX
  (setq-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook)
    +format-with-lsp-provider 'biome))

;; Start LSP in TreeSitter modes
(add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!)
