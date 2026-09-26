# nix-darwin settings every Mac gets, including one that is only reached over
# SSH (siraken-macmini). Anything for a Mac you sit in front of — macOS
# defaults, keyboard, fonts, the window manager — belongs in `workstation.nix`.
{
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
      trusted-users = [
        "root"
        userProfile.username
      ];
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
