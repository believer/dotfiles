;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!
(setq doom-font (font-spec :family "MonoLisa" :size 11))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-tokyo-night)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/.orgfiles/")
(setq org-agenda-files (directory-files-recursively org-directory "\\.org$"))

;; Log time when task was closed
(setq org-log-done 'time)

;; Default org file
(setq org-default-notes-file (concat org-directory "notes.org"))

;; Capture templates
(setq org-capture-templates
      `(
        ("t" "Task" entry
         (file+headline ,(concat org-directory "tasks.org") "Tasks")
         "* TODO %?\n%^t\n%a\n")
        ))

;; Skip confirm to exit message
(setq confirm-kill-emacs nil)

;; Display thin caret in insert mode
(after! evil
  (unless (display-graphic-p)
    (require 'evil-terminal-cursor-changer)
    (evil-terminal-cursor-changer-activate)))

;; Calendars start on Monday
(setq calendar-week-start-day 1)

;; Formatting
;; Go
(after! go-mode
  ;; Use goimports which uses gofmt, but also imports
  (setq gofmt-command "goimports")
  (add-hook 'before-save-hook #'gofmt-before-save))

;; Move files to trash when deleting in dired
(setq delete-by-moving-to-trash t
      trash-directory "~/.Trash")

;; Use TreeSitter mode for TypeScript
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))

(after! lsp-mode
  ;; Map treesitter modes
  (add-to-list 'lsp-language-id-configuration '(typescript-ts-mode . "typescript"))
  (add-to-list 'lsp-language-id-configuration '(tsx-ts-mode . "typescriptreact"))

  ;; Register Biome LSP
  (lsp-register-client
   (make-lsp-client
    :new-connection (lsp-stdio-connection (lambda () '("biome" "lsp-proxy")))
    :activation-fn (lsp-activate-on "typescript" "typescriptreact" "javascript")
    :server-id 'biome
    ;; This is essential to enable multiple servers
    :add-on? t))

  ;; Allowed clients
  (setq lsp-enabled-clients '(biome ts-ls))

  ;; Biome is primary formatter
  (setq-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook)
    +format-with-lsp-provider 'biome))

;; Start LSP in TreeSitter modes
(add-hook! '(typescript-ts-mode-hook tsx-ts-mode-hook) #'lsp!)

;; Setup Denote
(use-package! denote
  :config
  (setq denote-directories (list (expand-file-name (concat org-directory "notes"))))
  (setq denote-dired-directories (list (expand-file-name (concat org-directory "notes"))))
  (add-hook 'dired-mode-hook #'denote-dired-mode-in-directories)
  (add-hook 'dired-mode-hook #'dired-hide-details-mode))

;; Global Org Author in case of exporting instead of adding it to every file
(setq user-full-name "Rickard Natt och Dag")

;; Setup map for new note
(map! :leader
      :prefix "n"
      :desc "New note"  "n" #'denote
      :desc "Link note" "l" #'denote-link)
