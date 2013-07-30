(column-number-mode 1)
(show-paren-mode t)
(add-to-list 'load-path "~/.emacs.d" t)

;; Don't show the startup screen.
(setq inhibit-startup-message t)

;; Use y/n instead of yes/no.
(fset 'yes-or-no-p 'y-or-n-p)

;; Always nuke trailing whitespace.
(add-hook 'before-save-hook (lambda () (delete-trailing-whitespace)))

;; Indicate empty lines at the end of a buffer.
(set-default 'indicate-empty-lines t)

;; Save buffers across sessions.
(desktop-save-mode 1)

;; Except dired buffers.
(add-to-list 'desktop-modes-not-to-save 'dired-mode)

;; Autosave desktop when files are saved, rather than just on exit.
(defun my-desktop-save ()
    (interactive)
    ;; Don't call desktop-save-in-desktop-dir, as it prints a message.
    (if (eq (desktop-owner) (emacs-pid))
        (desktop-save desktop-dirname)))
(add-hook 'auto-save-hook 'my-desktop-save)

;; Make it easy to highlight a column.
(require 'column-marker)
(defun jws-mark-overflow-column ()
  (interactive)
  (column-marker-3 80))
(add-hook 'c-mode-hook 'jws-mark-overflow-column)
(add-hook 'clojure-mode-hook 'jws-mark-overflow-column)

;; Autocomplete close tags in nxml-mode.
(set-variable 'nxml-slash-auto-complete-flag t)

;; Display function documentation in echo area.
(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)

;; Highlighting and indentation for Urbiscript files.
(autoload 'urbiscript-mode "urbiscript-mode"
	"Mode for editing urbiscript source files" t)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

;; haskell-mode
(load "~/.emacs.d/haskell-mode/haskell-site-file")
(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)

;; SLIME
(add-to-list 'load-path "~/.emacs.d/slime/")
(setq inferior-lisp-program "/opt/local/bin/sbcl")
(require 'slime)
(slime-setup '(slime-fancy))

;; Proof General - generic front-end for interactive theorem provers
;; (load-file "~/.emacs.d/ProofGeneral/generic/proof-site.el")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
;(when
;    (load
;     (expand-file-name "~/.emacs.d/elpa/package.el"))

(require 'package)
;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages"))
(add-to-list 'package-archives
  '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives '("Tromey" . "http://tromey.com/elpa/") t)

;; Code working with packages installed by elpa must follow package-initialize!
(package-initialize)

;; Smart tab completion.
(require 'smart-tab)
(global-smart-tab-mode 1)

;; Smart M-x, built on ido-mode.
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; ace jump mode - quick on-screen navigation
(require 'ace-jump-mode)
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; undo-tree-mode everywhere!
(global-undo-tree-mode)

;; highlight yank/undo changes
(require 'volatile-highlights)
(volatile-highlights-mode t)

;; "do the right thing" indentation - autodetects spaces/tabs and tab width
(autoload 'dtrt-indent-mode
  "dtrt-indent" "Adapt to foreign indentation offsets" t)
(add-hook 'c-mode-common-hook 'dtrt-indent-mode)

;; Set up paredit-mode.
(autoload 'paredit-mode "paredit")
					;  "Minor mode for pseudo-structurally editing Lisp code." t)
(add-hook 'emacs-lisp-mode-hook       (lambda () (paredit-mode +1)))
(add-hook 'lisp-mode-hook             (lambda () (paredit-mode +1)))
(add-hook 'lisp-interaction-mode-hook (lambda () (paredit-mode +1)))
(add-hook 'scheme-mode-hook           (lambda () (paredit-mode +1)))
(add-hook 'clojure-mode-hook
	  (lambda ()
	    (paredit-mode +1)
	    (local-set-key (kbd "M-[") 'paredit-wrap-square)
	    (local-set-key (kbd "M-{") 'paredit-wrap-curly)))

;; Clojure configuration
(add-hook 'clojure-mode-hook (function rainbow-delimiters-mode))
(add-hook 'nrepl-interaction-mode-hook (function nrepl-turn-on-eldoc-mode))
(add-hook 'nrepl-mode-hook (function subword-mode)) ;treat CamelCase components as words
(add-hook 'nrepl-mode-hook (function paredit-mode))
(add-hook 'nrepl-mode-hook (function rainbow-delimiters-mode))

(add-hook 'slime-repl-mode-hook
	  (defun clojure-mode-slime-font-lock ()
            (require 'clojure-mode)
            (let (font-lock-mode)
	      (clojure-mode-font-lock-setup))))


;; Teach eldoc to refresh its docs after paredit motion.
(require 'eldoc) ; if not already loaded
(eldoc-add-command
 'paredit-backward-delete
 'paredit-close-round)

;; Gambit Scheme support
(autoload 'gambit-inferior-mode "gambit" "Hook Gambit mode into cmuscheme.")
(autoload 'gambit-mode "gambit" "Hook Gambit mode into scheme.")
(add-hook 'inferior-scheme-mode-hook (function gambit-inferior-mode))
(add-hook 'scheme-mode-hook (function gambit-mode))
(setq scheme-program-name "gsi -:d-")

;; nxml helpers
(add-hook 'nxml-mode-hook (lambda () (load-file "jws-docbook.el")))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(coq-prog-args (quote ("-I" "~/Documents/Cpdt/cpdt/src")))
 '(exec-path (quote ("/usr/bin" "/bin" "/usr/sbin" "/sbin" "/Users/jeremy/Applications/Emacs.app/Contents/MacOS/bin" "/usr/local/bin" "/usr/local/sbin")))
 '(ispell-dictionary "english"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
