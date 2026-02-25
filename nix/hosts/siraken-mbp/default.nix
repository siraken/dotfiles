{
  inputs,
  userProfile,
  backupFileExtension,
}:
inputs.nix-darwin.lib.darwinSystem {
  system = "aarch64-darwin";
  specialArgs = {
    inherit inputs userProfile;
    hostName = "siraken-mbp";
  };
  modules = [
    ../../modules/darwin/common.nix
    {
      services = {
        spotifyd = {
          enable = true;
          settings = {
            username = userProfile.username;
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
          "coursier"
          "duck"
          "earthly"
          "ethereum"
          "ffmpeg"
          "ggshield"
          "giflib"
          "git-filter-repo"
          "git-secrets"
          "goreleaser"
          "gpg"
          "hashcat"
          "hydra"
          "ios-deploy"
          "jmeter"
          "jpeg"
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
          "streamlink"
          "telnet"
          "testdisk"
          "tnftp"
          "w3m"
          "watchman"
          "wego"
          "wimlib"
          "xsv"
          "zola"
          "pinact"
        ];
        casks = [
          "alt-tab"
          "appcleaner"
          "audacity"
          "azure-data-studio"
          "background-music"
          "balenaetcher"
          "bitcoin-core"
          "blackhole-2ch"
          "blackhole-16ch"
          "blackhole-64ch"
          "blender"
          "brave-browser"
          "burp-suite"
          "chatgpt"
          "chromium" # args: { "no-quarantine": true }
          "claude"
          "cloudflare-warp"
          "cyberduck"
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
          "google-chrome"
          "google-drive"
          "hammerspoon"
          "handbrake-app"
          "imageoptim"
          "jetbrains-toolbox"
          "keycastr"
          "linear-linear"
          "lm-studio"
          "local"
          "logitech-g-hub"
          "microsoft-teams"
          "minecraft"
          "notion"
          "numi"
          "obs"
          "obsidian"
          "onedrive"
          "onyx"
          "poedit"
          "postman"
          "powershell"
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
          "unity-hub"
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
    inputs.nix-index-database.darwinModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    {
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.default
      ];
    }
    inputs.home-manager.darwinModules.home-manager
    {
      users.users = {
        "${userProfile.username}" = {
          name = "${userProfile.username}";
          home = "/Users/${userProfile.username}";
        };
      };
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = backupFileExtension;
        users.${userProfile.username} = ./home.nix;
        sharedModules = [
          inputs.nixvim.homeModules.nixvim
        ];
        extraSpecialArgs = { inherit inputs userProfile; };
      };
    }
  ];
}
