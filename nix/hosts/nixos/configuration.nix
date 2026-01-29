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
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Networking
  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # Timezone and locale
  time.timeZone = "Asia/Tokyo";
  i18n.defaultLocale = "en_US.UTF-8";

  # Japanese input
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc
      fcitx5-gtk
    ];
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

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # VMware guest tools
  virtualisation.vmware.guest.enable = true;

  # XDG portal for screen sharing etc.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

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
    # Hyprland essentials
    waybar
    wofi
    kitty
    mako
    swww
    grim
    slurp
    wl-clipboard
    brightnessctl
    pamixer
    thunar
    networkmanagerapplet
  ];

  # Enable SSH
  services.openssh.enable = true;

  # System version
  system.stateVersion = "25.11";
}
