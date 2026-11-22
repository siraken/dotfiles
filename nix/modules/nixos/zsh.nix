# zsh as the login shell on every NixOS host.
#
# The shell configuration itself is home-manager's (nix/programs/zsh). The
# system side is still needed: NixOS refuses a user shell whose program is not
# enabled, and /etc/zshenv is what loads the system environment
# (set-environment) into a zsh session.
{ pkgs, userProfile, ... }:
{
  programs.zsh = {
    enable = true;

    # home-manager's .zshrc already runs compinit and starship draws the
    # prompt, so keep /etc/zshrc from doing either a second time.
    # `enableCompletion` stays on: it links the packages' share/zsh
    # completions into the system profile.
    enableGlobalCompInit = false;
    promptInit = "";
  };

  users.users.${userProfile.username}.shell = pkgs.zsh;
}
