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
        ];
        brews = [
          "apktool"
          "arduino-cli"
          "azure-cli"
          "bats-core"
          "cabextract"
          "cdrtools"
          "cocoapods"
          "coursier"
          "earthly"
          "ethereum"
          "ffmpeg"
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
          "pixman"
          "pkg-config"
          "portaudio"
          "pwgen"
          "qemu"
          "redis"
          "samba"
          "skaffold"
          "smartmontools"
          "solidity"
          "sqlite"
          "streamlink"
          "telnet"
          "testdisk"
          "tnftp"
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
          "background-music"
          "blackhole-2ch"
          "blackhole-16ch"
          "blackhole-64ch"
          "blender"
          "burp-suite"
          "chatgpt"
          "claude"
          "cursor"

          "cyberduck"
          "discord"
          "docker-desktop"
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
          "google-chrome@beta"
          "google-chrome@canary"
          "google-drive"
          "hammerspoon"
          "handbrake-app"
          "imageoptim"
          "jetbrains-toolbox"
          "keycastr"
          "linear"
          "lm-studio"
          "logitech-g-hub"
          "microsoft-teams"
          "minecraft"
          "notion"
          "numi"
          "obs"
          "obsidian"
          "onedrive"
          "onyx"
          "postman"
          "raspberry-pi-imager"
          "raycast"
          "sdformatter"
          "session-manager-plugin"
          "sf-symbols"
          "spotify"
          "steam"
          "sublime-text"
          "tableplus"
          "termius"
          "tor-browser"
          "transmit"
          "unity-hub"
          "visual-studio-code"
          "vlc"
          "wezterm"
          "whisky"
          "wireshark-app"
          "xquartz"
          "zoom"
          "zulu@17"
        ];
      };
    }
    inputs.nix-index-database.darwinModules.nix-index
    { programs.nix-index-database.comma.enable = true; }
    {
      nixpkgs.overlays = [
        inputs.llm-agents.overlays.shared-nixpkgs
        # mise 2026.6.11: OCI layer setuid test fails in Nix sandbox
        (final: prev: {
          mise = prev.mise.overrideAttrs (old: {
            doCheck = false;
          });
        })
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
