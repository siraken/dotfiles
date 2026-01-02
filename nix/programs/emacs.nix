{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;

    extraPackages = epkgs: with epkgs; [
      use-package
      auto-complete
      helm
      flycheck
      projectile
      cider
      tide
      slime
      paredit
      dashboard
      neotree
      undo-tree
      rainbow-delimiters
      which-key
      multiple-cursors
      evil
      # Mode
      lsp-mode
      web-mode
      emmet-mode
      js2-mode
      markdown-mode
      clojure-mode
      php-mode
      yaml-mode
      scss-mode
      dockerfile-mode
      csharp-mode
      rust-mode
      swift-mode
      lua-mode
      kotlin-mode
      nim-mode
      go-mode
      # Git
      magit
      git-gutter
      # Line
      doom-modeline
      # Theme
      zenburn-theme
      doom-themes
    ];

    extraConfig = ''
      ;;; init.el --- Initialization file for Emacs
      ;; Author: siraken
      ;; Maintainer: siraken

      ;;; Commentary:
      ;; Managed by home-manager

      ;;; Code:

      ;; https://github.com/magit/magit
      (use-package magit)

      ;; https://github.com/flycheck/flycheck
      (use-package flycheck
        :ensure t
        :config
        (add-hook 'after-init-hook #'global-flycheck-mode))

      ;; https://github.com/doomemacs/themes
      (use-package doom-themes
        :ensure t
        :config
        (setq doom-themes-enabled-bold t
              doom-themes-enabled-italic t)
        (load-theme 'doom-tokyo-night t))

      ;; https://github.com/seagle0128/doom-modeline
      (use-package doom-modeline
        :ensure t
        :init (doom-modeline-mode 1))

      ;; https://github.com/auto-complete/auto-complete
      (use-package auto-complete)
      (use-package auto-complete-config)

      ;; https://github.com/emacs-evil/evil
      (use-package evil)

      (global-auto-complete-mode 1)
      (global-git-gutter-mode 1)

      ;;
      ;; Emacs Configuration
      ;;
      (defalias 'yes-or-no-p 'y-or-n-p)

      (if window-system
          (progn
            (set-frame-parameter nil 'alpha 75)))

      (global-display-line-numbers-mode 1)

      (add-to-list 'default-frame-alist '(cursor-type . bar))
      (add-to-list 'default-frame-alist '(cursor-type . hbar))
      (add-to-list 'default-frame-alist '(cursor-type . (hbar . 10)))
      (add-to-list 'default-frame-alist '(cursor-type . box))
      (add-to-list 'default-frame-alist '(cursor-type . hollow))

      (set-default-coding-systems 'utf-8)
      (prefer-coding-system 'utf-8)

      (blink-cursor-mode t)

      (setq-default indicate-empty-lines t)
      (setq-default indicate-buffer-boundaries 'left)

      (tool-bar-mode 0)
      (display-time)
      (menu-bar-mode 0)
      (show-paren-mode 1)
      (transient-mark-mode 1)
      (which-function-mode 1)
      (xterm-mouse-mode 1)

      (delete-selection-mode t)
      (cua-mode t)

      (setq inhibit-startup-message 1)
      (setq initial-scratch-message "")
      (setq scroll-conservatively 1)
      (setq case-fold-search t)
      (setq make-backup-files nil)
      (setq auto-save-default nil)
      (setq select-enable-clipboard t)
      (setq mac-command-modifier 'super)
      (setq default-tab-width 4)
      (setq cua-enable-cua-keys nil)
    '';
  };
}
