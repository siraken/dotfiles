{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  username = "siraken";
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 5; # Keep only 5 boot entries
    };
    efi.canTouchEfiVariables = true;
  };

  # Networking
  networking = {
    hostName = "nixos-vm";
    networkmanager.enable = true;
  };

  # Timezone and locale
  time.timeZone = "Asia/Tokyo";

  i18n = {
    defaultLocale = "en_US.UTF-8";
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5.addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
      ];
    };
  };

  # Nix settings
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # User account
  users.users.${username} = {
    isNormalUser = true;
    description = username;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
      "input"
    ];
    initialPassword = "nixos";
  };

  # Services
  services = {
    # X11 & i3
    xserver = {
      enable = true;
      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          i3status
          i3lock
          dmenu
          rofi
        ];
      };
      displayManager.lightdm.enable = true;
    };

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };

    # SSH
    openssh.enable = true;
  };

  # VMware guest tools
  virtualisation.vmware.guest.enable = true;

  # Fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.hack
    nerd-fonts.jetbrains-mono
  ];

  # System packages
  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
    tree
    neofetch
    htop
    eza
    bat
    ripgrep
    fd
    jq
    # i3 essentials
    kitty
    feh
    picom
    dunst
    maim
    xclip
    arandr
    pavucontrol
    networkmanagerapplet
    thunar
    lxappearance
  ];

  # System version
  system.stateVersion = "25.11";
}
