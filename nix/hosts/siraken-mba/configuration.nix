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
      # Leaves Omarchy's limine on the shared ESP alone. Installing puts
      # systemd-boot first in the UEFI boot order, so Omarchy is reached through
      # the entry below (or the Mac boot picker, hold Option) until #244.
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
        extraEntries."omarchy.conf" = ''
          title Omarchy (Limine)
          efi /EFI/limine/limine_x64.efi
          sort-key z-omarchy
        '';
      };
      efi.canTouchEfiVariables = true;
    };

    # A splash from the LUKS prompt to the desktop, as on Omarchy: Plymouth asks
    # for the passphrase (i915 is in the initrd for it), and the kernel and
    # systemd keep their messages off the screen. Esc shows them.
    plymouth.enable = true;
    consoleLogLevel = 3;
    # Plymouth adds "splash" itself.
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "rd.udev.log_level=3"
      "systemd.show_status=auto"
    ];
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

  # JIS internal keyboard on the console (Hyprland sets its own layout), from
  # the initrd on, where the LUKS passphrase is typed.
  console = {
    keyMap = "jp106";
    earlySetup = true;
  };

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

  services = {
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

  virtualisation.docker = {
    enable = true;
    # Started by its socket on first use rather than on every boot (#286).
    enableOnBoot = false;
  };

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
