(require 'package)

(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ;; ("melpa-stable" . "https://stable.melpa.org/packages/")
        ("org" . "https://orgmode.org/elpa/")
        ("gnu" . "https://elpa.gnu.org/packages/")))

;; Initialize
(package-initialize)

(defvar my/packages
  '(
    ;; git
    magit git-gutter
    ))

;; Install packages
(dolist (package my/packages)
  (unless (package-installed-p package)
    (package-install package)))

(require 'linum)
(global-linum-mode 1)

(display-time)

(menu-bar-mode 0)

(show-paren-mode 1)

(transient-mark-mode 1)

(setq mac-command-modifier 'super)

;; Do not show menu on terminal
(if (eq window-system 'x)
    (menu-bar-mode 1) (menu-bar-mode 0))
(menu-bar-mode nil)

;; Ignore caps
(setq case-fold-search t)

;; Copy to clipboard
(setq x-select-enable-clipboard t)

;; Do not create *.~ backup file
(setq make-backup-files nil)

;; Do not create .#* backup file
(setq auto-save-default nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(git-gutter magit)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
