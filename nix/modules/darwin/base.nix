# nix-darwin settings every Mac gets, including one that is only reached over
# SSH (siraken-macmini). Anything for a Mac you sit in front of — macOS
# defaults, keyboard, fonts, the window manager — belongs in `workstation.nix`.
{
  lib,
  pkgs,
  userProfile,
  hostName,
  ...
}:
{
  imports = [
    ../nix-caches.nix
  ];

  nix = {
    nixPath = [ ];

    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      # nix-darwin already trusts root by default.
      trusted-users = [ userProfile.username ];
      # substituters and trusted-public-keys are defined in ../nix-caches.nix
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config = {
      allowUnfree = true;
    };
  };

  networking.hostName = hostName;

  # Reachable over SSH at any time.
  services.openssh.enable = true;
  power.sleep.computer = "never";

  security.pam.services.sudo_local = {
    touchIdAuth = true;
    watchIdAuth = true;
  };

  environment = {
    shells = import ../shells.nix { inherit pkgs; };
    # Put Homebrew after Nix profiles (order 1000) and before macOS system
    # paths (order 1200) so Nix packages take priority over Homebrew formulas
    # while Homebrew (including keg-only openssl@3) still beats Apple's /usr/bin.
    systemPath = lib.mkOrder 1100 (import ../path.nix { inherit lib pkgs; }).homebrew;
  };

  # The user's zsh is configured by home-manager (`nix/programs/zsh`, part of
  # every profile), which runs its own compinit and sets the prompt through
  # starship. nix-darwin's defaults would do both again in /etc/zshrc: a second
  # compinit (with its compaudit pass, ~50 ms per shell) and a `prompt suse`
  # that starship immediately replaces. Completions stay installed and on
  # fpath; only the duplicate calls go.
  programs.zsh = {
    enableGlobalCompInit = false;
    promptInit = "";
  };

  system = {
    stateVersion = 5;
    primaryUser = userProfile.username;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = false;
      cleanup = "none";
    };
    taps = [
    ];
  };
}
