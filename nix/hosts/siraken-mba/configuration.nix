# MacBook Air (Early 2014) on NixOS, replacing its Omarchy install.
#
# The OS layer only: the user environment is `siraken@siraken-mba` (see
# ./home.nix). Hardware lives in ./hardware.nix and the disks in
# ./hardware-configuration.nix.
{
  pkgs,
  userProfile,
  ...
}:
{
  boot = {
    loader = {
      # Leaves Omarchy's limine on the shared ESP alone, so it stays reachable
      # from the Mac boot picker (hold Option) during the migration.
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "siraken-mba";
    networkmanager.enable = true;
  };

  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = {
        waylandFrontend = true;
        addons = [ pkgs.fcitx5-mozc ];
      };
    };
  };

  # JIS internal keyboard on the console (Hyprland sets its own layout).
  console.keyMap = "jp106";

  nix = {
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };

  nixpkgs.config.allowUnfree = true;

  users.users.${userProfile.username} = {
    isNormalUser = true;
    description = userProfile.name;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
      "docker"
    ];
  };

  # Swap in daily use; the swapfile is only for hibernation.
  zramSwap.enable = true;

  # Desktop: Hyprland under UWSM, started from greetd. Its configuration is
  # home-manager's (config/hypr is still Omarchy's and does not load here).
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  services = {
    greetd = {
      enable = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-uwsm.desktop'";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    printing.enable = true;
    avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };

  security.polkit.enable = true;

  programs = {
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ userProfile.username ];
    };
  };

  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  system.stateVersion = "26.11";
}
