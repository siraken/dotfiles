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

  boot = {
    # Bootloader
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5; # Keep only 5 boot entries
      };
      efi.canTouchEfiVariables = true;
    };

    kernelParams = [ "video=1920x1080" ];
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
      "docker"
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
      videoDrivers = [
        "vmware"
        "virtio"
      ];
    };

    # Audio
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
      # Reduce audio stuttering in VM
      extraConfig.pipewire = {
        "99-vm-latency" = {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 2048;
            "default.clock.min-quantum" = 1024;
          };
        };
      };
    };

    # SSH
    openssh.enable = true;
  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [ mesa ];
    };
  };

  # Virtualisation
  virtualisation = {
    # VMware guest tools
    vmware.guest = {
      enable = true;
      headless = false; # Enable GUI support
    };

    # Docker
    docker = {
      enable = true;
      autoPrune.enable = true; # Automatically clean up unused images/containers
    };
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
    # Browser & Media
    firefox
    chromium
    vlc
  ];

  # System version
  system.stateVersion = "25.11";
}
