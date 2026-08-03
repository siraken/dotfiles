# Home-manager settings shared by *every* profile (macOS, NixOS, WSL).
#
# Only what was previously duplicated in all five host `home.nix` files lives
# here — the program set below is exactly their intersection. Anything narrower
# belongs in `profile-full.nix` (daily-driver machines), `profile-darwin.nix`
# (macOS-only), or the host profile itself.
{
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./mk-repo-link.nix
    # programs (present on every profile)
    ../../programs/atuin
    ../../programs/awscli
    ../../programs/bash
    ../../programs/bat
    ../../programs/bottom
    ../../programs/direnv
    ../../programs/fzf
    ../../programs/gh-dash
    ../../programs/git
    ../../programs/gitui
    ../../programs/helix
    ../../programs/lazydocker
    ../../programs/mise
    ../../programs/scripts
    ../../programs/starship
    ../../programs/tmux
    ../../programs/vim
    ../../programs/yazi
    ../../programs/yt-dlp
    ../../programs/zellij
    ../../programs/zoxide
    ../../programs/zsh
  ];

  home = {
    stateVersion = "26.05";
    # preferXdgDirectories = true; # to be enabled
    sessionPath = import ../path.nix { inherit lib pkgs; };
    shellAliases = import ../aliases.nix { inherit pkgs; };
    packages = import ../nixpkgs.nix { inherit pkgs; };

    # `mkDefault` so a host that leaves a shell out (fish on wsl-nixos and
    # nixos-vm) can switch its integration off.
    shell = {
      enableBashIntegration = lib.mkDefault true;
      enableFishIntegration = lib.mkDefault true;
      enableZshIntegration = lib.mkDefault true;
      enableShellIntegration = lib.mkDefault true;
    };
  };

  programs = {
    home-manager.enable = true;

    # Building the man page cache is expensive and it is regenerated whenever a
    # package changes. Previously set on siraken-mbp only, which left every
    # other host paying for it.
    man.generateCaches = false;
  };
}
