{ pkgs, config, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-nox;

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

    # Load init.el directly from the repo checkout so it is editable in place
    # (next emacs start picks up edits — no rebuild). The generated default.el
    # now loads the repo file instead of inlining it; same load timing. See #70.
    extraConfig = ''
      (load-file "${config.home.homeDirectory}/dotfiles/nix/programs/emacs/config/init.el")
    '';
  };
}
