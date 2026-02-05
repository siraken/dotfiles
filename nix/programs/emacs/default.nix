{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;

    extraPackages =
      epkgs: with epkgs; [
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

    extraConfig = builtins.readFile ./config/init.el;
  };
}
