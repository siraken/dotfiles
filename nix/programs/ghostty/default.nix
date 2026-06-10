{ pkgs, config, ... }:
let
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.ghostty = {
    enable = true;
    package =
      if isDarwin then
        # TODO: use package for macOS (for now, set `null` to use brew-installed version)
        null
      else
        pkgs.ghostty;
    settings = {
      # Static settings live in a repo file read directly by ghostty via the
      # `config-file` directive, so they are editable in place (ghostty reloads
      # without a rebuild). Only the host-varying `font-size` stays in Nix,
      # alongside the darwin/linux `package` choice. See #70.
      config-file = "${config.home.homeDirectory}/dotfiles/config/ghostty/config";
      font-size = if isDarwin then 16 else 12;
    };
  };
}
