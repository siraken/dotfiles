{ config, ... }:
{
  programs.kitty = {
    enable = true;

    # Static settings live in a repo file included directly by kitty, so they
    # are editable in place (kitty reloads without a rebuild). home-manager
    # still owns the generated kitty.conf (e.g. shell integration). See #70.
    extraConfig = ''
      include ${config.home.homeDirectory}/dotfiles/config/kitty/kitty.conf
    '';
  };
}
