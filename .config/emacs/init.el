;;; init.el --- Initialization file for Emacs

;; Author: siraken
;; Maintainer: siraken

;;; Commentary:

;;; Code:

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
    auto-complete
    helm
    flycheck
    projectile
    cider
    ;; Mode
    markdown-mode
    clojure-mode
    ;; git
    magit
    git-gutter
    ;; Line
    doom-modeline
    ;; Theme
    zenburn-theme
    doom-themes
    ))

;; Install packages
(dolist (package my/packages)
  (unless (package-installed-p package)
    (package-install package)))

;; Enable packages
(require 'doom-themes)
(require 'doom-modeline)
(require 'magit)
(require 'auto-complete)
(require 'auto-complete-config)

(doom-modeline-mode 1)

(global-auto-complete-mode +1)
(global-flycheck-mode +1)

(global-display-line-numbers-mode 1)

(display-time)

(menu-bar-mode 0)

(show-paren-mode 1)

(transient-mark-mode 1)

(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

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
