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

  # User account
  users.users.${userProfile.username} = {
    isNormalUser = true;
    description = userProfile.username;
    extraGroups = [
      "wheel"
    ];
  };

  # Virtualisation
  virtualisation.docker = {
    rootless = {
      enable = true;
      setSocketVariable = true;
    };
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
