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

  # Programs
  programs = {
    # Sway (Wayland)
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
        swaylock
        swayidle
        waybar
        wofi
        mako # notification daemon
        grim # screenshot
        slurp # region selection
        wl-clipboard
        wdisplays # display configuration
        swaybg # wallpaper
      ];
    };
  };

  # XDG portal for Wayland
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Security (required for Sway)
  security.polkit.enable = true;

  # Services
  services = {
    # Video drivers
    xserver.videoDrivers = [ "virtio" ];

    # greetd (Wayland display manager)
    greetd = {
      enable = true;
      settings = {
        default_session = {
          command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd sway";
          user = "greeter";
        };
      };
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

  # Environment variables for Wayland
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1"; # Firefox Wayland mode
    WLR_NO_HARDWARE_CURSORS = "1"; # Avoid software rendering issues
  };

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
    # Desktop essentials
    kitty
    pavucontrol
    networkmanagerapplet
    thunar
    # Browser & Media
    firefox
    chromium
    vlc
  ];

  # System version
  system.stateVersion = "25.11";
}
