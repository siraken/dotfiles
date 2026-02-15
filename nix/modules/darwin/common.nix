{
  config,
  pkgs,
  userProfile,
  hostName,
  ...
}:
let
  homeDir = config.users.users.${userProfile.username}.home;
  userPaths = import ../user-paths.nix { inherit homeDir; };
in
{
  imports = [
    ./launchd-services.nix
    ./nix-caches.nix
    ../../services/darwin/sketchybar
    ../../services/tailscale.nix
  ];

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      trusted-users = [
        "root"
        userProfile.username
      ];
      substituters = [
        "https://cache.nixos.org/"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://cache.numtide.com"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };

  networking.hostName = hostName;

  environment = {
    shells = import ../shells.nix { inherit pkgs; };
    systemPackages = [
      pkgs.nil
    ];
  };

  system = {
    stateVersion = 5;
    primaryUser = userProfile.username;
    defaults = {
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
      NSGlobalDomain = {
        NSWindowShouldDragOnGesture = true;
        "com.apple.mouse.tapBehavior" = 1;

        # Keyboard
        InitialKeyRepeat = 15; # Key repeat delay (default: 25)
        KeyRepeat = 2; # Key repeat speed (default: 6, lower = faster)
        ApplePressAndHoldEnabled = false; # Disable press-and-hold for keys (enables key repeat)

        # Appearance
        AppleInterfaceStyle = "Dark";
        _HIHideMenuBar = true; # Auto-hide menu bar

        # Disable auto-correction features
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;

        # Trackpad (in NSGlobalDomain)
        "com.apple.trackpad.forceClick" = true;
      };

      # Trackpad settings
      trackpad = {
        Clicking = true; # Tap to click
        TrackpadRightClick = true; # Two-finger right click
        TrackpadThreeFingerDrag = false;
        TrackpadPinch = true; # Pinch to zoom
        TrackpadRotate = true; # Two-finger rotate
        TrackpadMomentumScroll = true;
        FirstClickThreshold = 1; # Click pressure (0=light, 1=medium, 2=firm)
        SecondClickThreshold = 1;
      };

      # Menu bar clock
      menuExtraClock = {
        ShowAMPM = true;
        ShowDate = 0; # 0=hide, 1=show, 2=show with day of week
        ShowDayOfWeek = true;
      };

      # Window Manager (Stage Manager)
      WindowManager = {
        GloballyEnabled = false; # Stage Manager disabled
        EnableStandardClickToShowDesktop = false;
        EnableTiledWindowMargins = false;
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };
      CustomUserPreferences = {
        "com.apple.screensaver" = {
          idleTime = 180;
        };
        "com.microsoft.VSCode" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.jetbrains.PhpStorm" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.jetbrains.WebStorm" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.jetbrains.rubymine" = {
          ApplePressAndHoldEnabled = false;
        };
      };
    };
  };

  power = {
    sleep = {
      computer = "never";
      display = 5;
      harddisk = 10;
    };
  };

  services = {
    openssh.enable = true;
  };

  # Custom launchd services (managed by nix/modules/darwin/launchd-services.nix)
  customServices = {
    ollama = {
      enable = true;
      package = pkgs.ollama;
      command = [
        "${pkgs.ollama}/bin/ollama"
        "serve"
      ];
      environment = {
        OLLAMA_HOST = "127.0.0.1:11434";
      };
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_14;
      command = [
        "${pkgs.postgresql_14}/bin/postgres"
        "-D"
        (userPaths.dataDir "postgresql")
      ];
      environment = {
        LC_ALL = "en_US.UTF-8";
        LANG = "en_US.UTF-8";
      };
    };
  };

  security = {
    pam = {
      services = {
        sudo_local = {
          touchIdAuth = true;
          watchIdAuth = true;
        };
      };
    };
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };
    taps = [
      "siraken/homebrew-tap"
      "novalumo/homebrew-tap"
    ];
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.hack
      source-code-pro
      monocraft
      udev-gothic
    ];
  };
}
