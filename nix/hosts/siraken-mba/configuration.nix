# MacBook Air (Early 2014) on NixOS, which replaced its Omarchy install.
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
      systemd-boot = {
        enable = true;
        configurationLimit = 3;
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

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Keep the last three generations, of the system and of every user's
  # profiles (home-manager included), and collect the rest weekly. nix.gc can
  # only keep by age.
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep 3";
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

  # Suspend, and hibernate after two hours asleep so a forgotten machine does
  # not run flat. Closing the lid and hypridle's last step both do this.
  # Resuming from hibernation asks for the LUKS passphrase and takes about a
  # minute and a half.
  systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    # The power key sits above Delete and is easy to press by mistake. A press
    # only opens wlogout (Hyprland's XF86PowerOff binding); logind would
    # otherwise power off at once. A long press still powers off a frozen
    # machine.
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "poweroff";
  };

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

  environment.systemPackages = with pkgs; [
    vim
    git
    curl
    wget
  ];

  system.stateVersion = "26.11";
}
