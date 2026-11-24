;;; init.el --- Initialization file for Emacs -*- lexical-binding: t; -*-
;; Author: siraken
;; Maintainer: siraken

;;; Commentary:
;; Managed by home-manager

;;; Code:

;; Raise GC threshold during startup and restore afterward
(setq gc-cons-threshold most-positive-fixnum)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024))))

;; Increase read buffer for LSP / subprocess output (1 MiB)
(setq read-process-output-max (* 1024 1024))

(when (boundp 'native-comp-async-report-warnings-errors)
  (setq native-comp-async-report-warnings-errors 'silent))

;; https://github.com/magit/magit
(use-package magit
  :defer t)

;; https://github.com/flycheck/flycheck
(use-package flycheck
  :hook (after-init . global-flycheck-mode))

;; https://github.com/doomemacs/themes
(use-package doom-themes
  :config
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t)
  (load-theme 'doom-tokyo-night t))

;; https://github.com/seagle0128/doom-modeline
(use-package doom-modeline
  :config
  (doom-modeline-mode 1))

;; https://github.com/auto-complete/auto-complete
(use-package auto-complete
  :config
  (require 'auto-complete-config)
  (global-auto-complete-mode 1))

;; https://github.com/emacsorphanage/git-gutter
(use-package git-gutter
  :config
  (global-git-gutter-mode 1))

;; https://github.com/emacs-evil/evil
(use-package evil
  :defer t)

;;
;; Emacs Configuration
;;
(defalias 'yes-or-no-p 'y-or-n-p)

(when window-system
  (set-frame-parameter nil 'alpha 75))

(global-display-line-numbers-mode 1)

(add-to-list 'default-frame-alist '(cursor-type . hollow))

(set-default-coding-systems 'utf-8)
(prefer-coding-system 'utf-8)

(blink-cursor-mode t)

(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)
(setq-default tab-width 4)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode 0))
(display-time)
(menu-bar-mode 0)
(show-paren-mode 1)
(transient-mark-mode 1)
(which-function-mode 1)
(xterm-mouse-mode 1)

(delete-selection-mode t)
(setq cua-enable-cua-keys nil)
(cua-mode t)

(setq inhibit-startup-message 1)
(setq initial-scratch-message "")
(setq scroll-conservatively 1)
(setq case-fold-search t)
(setq make-backup-files nil)
(setq auto-save-default nil)
(setq select-enable-clipboard t)
(setq mac-command-modifier 'super)

(provide 'init)
;;; init.el ends here
