{
  pkgs,
  userProfile,
  ...
}:
{
  # WSL settings
  wsl = {
    enable = true;
    defaultUser = userProfile.username;
  };

  # Networking
  networking = {
    hostName = "wsl-nixos";
  };

  # Timezone and locale
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
  };

  # Nix settings
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };

    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 7d";
    };
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User account
  users.users.${userProfile.username} = {
    isNormalUser = true;
    description = userProfile.username;
    extraGroups = [
      "wheel"
      "docker"
    ];
    initialPassword = "nixos";
  };

  # Services
  services = {
    openssh.enable = true;
  };

  # Virtualisation
  virtualisation.docker = {
    enable = true;
    rootless.enable = true;
    autoPrune.enable = true;
  };

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  # System version
  system.stateVersion = "26.05";
}
