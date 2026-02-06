{
  config,
  pkgs,
  user,
  ...
}:
let
  homeDir = config.users.users.${user.username}.home;
  userPaths = import ../../modules/user-paths.nix { inherit homeDir; };
in
{
  imports = [
    ../../modules/darwin/common.nix
  ];

  system.defaults = {
    # TODO:
    # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
    NSGlobalDomain = {
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

    spotifyd = {
      enable = true;
      settings = {
        username = user.username;
        use_keyring = true;
        device_name = "spotifyd @ Kento's MacBook Pro";
        device_type = "computer";
        device = "default";
        bitrate = 320;
        backend = "portaudio";
        initial_volume = 100;
        volume_controller = "softvol";
      };
    };
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
        # OLLAMA_MODELS = "/path/to/models";  # Optional: custom model path
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

  homebrew = {
    taps = [
      "VOICEVOX/voicevox"
    ];
    brews = [
      "aircrack-ng"
      "apktool"
      "arduino-cli"
      "azure-cli"
      "bats-core"
      "cabextract"
      "cairo"
      "cdrtools"
      "cfonts"
      "cocoapods"
      "composer"
      "coursier"
      "duck"
      "earthly"
      "ethereum"
      "ffmpeg"
      "ggshield"
      "ghcup"
      "gibo"
      "giflib"
      "git-filter-repo"
      "git-secrets"
      "gitui"
      "gnucobol"
      "goreleaser"
      "gpg"
      "grpc"
      "hashcat"
      "hydra"
      "imagemagick"
      "invoice"
      "ios-deploy"
      "jmeter"
      "jpeg"
      "leiningen"
      "libffi"
      "libiconv"
      "libpng"
      "libpq"
      "librsvg"
      "libxslt"
      "llvm"
      "luajit"
      "mas"
      "mist"
      "certbot"
      "monolith"
      "mplayer"
      "mysql"
      "openssl"
      "pango"
      "pdf2svg"
      "pdfcrack"
      "pixman"
      "pkg-config"
      "portaudio"
      "pure"
      "putty"
      "pwgen"
      "qemu"
      "redis"
      "samba"
      "shpotify"
      "skaffold"
      "sl"
      "smartmontools"
      "solidity"
      "sqlite"
      "stack"
      "streamlink"
      "telnet"
      "testdisk"
      "tnftp"
      "ttyd"
      "w3m"
      "watchman"
      "wego"
      "whalebrew"
      "wimlib"
      "xsv"
      "zola"
      "zplug"
      "pinact"
      "svn"
    ];
    casks = [
      "alt-tab"
      "appcleaner"
      "audacity"
      "azure-data-studio"
      "background-music"
      "balenaetcher"
      "bartender"
      "bitcoin-core"
      "blackhole-16ch"
      "blackhole-2ch"
      "blackhole-64ch"
      "blender"
      "blisk"
      "brave-browser"
      "brewlet"
      "burp-suite"
      "chatgpt"
      "chromium" # args: { "no-quarantine": true }
      "claude"
      "cloudflare-warp"
      "cursor"
      "cyberduck"
      "diffusionbee"
      "discord"
      "docker-desktop"
      "drawio"
      "drivedx"
      "dropbox"
      "elgato-camera-hub"
      "elgato-control-center"
      "elgato-stream-deck"
      "epic-games"
      "eqmac"
      "figma"
      "firefox"
      "firefox@developer-edition"
      "ghostty"
      "github"
      "gitify"
      "google-chrome"
      "google-drive"
      "hammerspoon"
      "handbrake-app"
      "hyper"
      "imageoptim"
      "jetbrains-toolbox"
      "keycastr"
      "lapce"
      "linear-linear"
      "lm-studio"
      "local"
      "logitech-g-hub"
      "mamp"
      "microsoft-teams"
      "min"
      "minecraft"
      "mjml-app"
      "notion"
      "numi"
      "obs"
      "obsidian"
      "onedrive"
      "onyx"
      "podman-desktop"
      "poedit"
      "postman"
      "powershell"
      "popclip"
      "raspberry-pi-imager"
      "raycast"
      "sdformatter"
      "session-manager-plugin"
      "sf-symbols"
      "sourcetree"
      "spotify"
      "steam"
      "streamlabs"
      "sublime-text"
      "tableplus"
      "termius"
      "thebrowsercompany-dia"
      "tor-browser"
      "transmit"
      "ngrok"
      "unity-hub"
      "vagrant"
      "visual-studio-code"
      "vivaldi"
      "vlc"
      "webtorrent"
      "wezterm"
      "whisky"
      "wireshark-app"
      "xbar"
      "xquartz"
      "xsplit-vcam"
      "zoom"
      "zulu@17"
      {
        name = "voicevox";
        args = {
          "no_quarantine" = true;
        };
      }
    ];
    masApps = {
      "Compressor" = 424390742;
      # "DaVinci Resolve" = 571213070;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "MainStage" = 634159523;
      "Motion" = 434290957;
      "DaisyDisk" = 411643860;
      "KakaoTalk" = 869223134;
      "Kindle" = 302584613;
      "LanScan" = 472226235;
      "LINE" = 539883307;
      "Messenger" = 1480068668;
      "Microsoft Excel" = 462058435;
      "Microsoft Outlook" = 985367838;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      # "RunCat" = 1429033973;
      "Slack" = 803453959;
      # "Spark" = 1176895641;
      # "Tailscale" = 1475387142;
      "The Unarchiver" = 425424353;
    };
  };
}
