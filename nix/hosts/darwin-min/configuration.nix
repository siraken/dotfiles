# https://nix-darwin.github.io/nix-darwin/manual/index.html
{ pkgs, modulePath, ... }:
{
  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  networking = {
    hostName = "Kentos-Darwin-Min";
    localHostName = "Kentos-Darwin-Min";
  };

  imports = [
    # ../../services/sketchybar.nix
    ../../services/spotifyd.nix
    # ../../programs/tmux.nix
  ];

  environment = {
    systemPackages = [
      pkgs.nil
    ];
  };

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;
    primaryUser = "siraken";
    defaults = {
      # TODO:
      # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
      # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
      dock = {
        orientation = "bottom";
        tilesize = 40;
        magnification = false;
        largesize = 64;
        autohide = true;
        autohide-time-modifier = 0.5;
        autohide-delay = 0.2;
        show-recents = true;
        mineffect = "scale";
        static-only = false;
        scroll-to-open = false;
        launchanim = true;
      };
      finder = {
        AppleShowAllExtensions = false;
        AppleShowAllFiles = false;
        ShowPathbar = true;
        ShowStatusBar = true;
      };
      CustomUserPreferences = {
        "com.microsoft.VSCode" = {
          ApplePressAndHoldEnabled = false;
        };
      };
    };
  };

  security = {
    pam = {
      services = {
        sudo_local = {
          watchIdAuth = true;
        };
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "none";
    };
    taps = [
    ];
    brews = [
    ];
    casks = [
    ];
    masApps = {
    };
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      source-code-pro
      monocraft
      udev-gothic
    ];
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
