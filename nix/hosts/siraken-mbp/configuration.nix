{
  user,
  ...
}:
{
  imports = [
    ../../modules/darwin/common.nix
  ];

  services = {
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
