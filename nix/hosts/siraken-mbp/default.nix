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
          "thunderbird"
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
