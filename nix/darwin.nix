# https://nix-darwin.github.io/nix-darwin/manual/index.html
{ pkgs, modulePath, ... }:
{
  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  networking = {
    hostName = "Kentos-MacBook-Pro";
    localHostName = "Kentos-MacBook-Pro";
  };

  imports = [
    ./environment/system-packages.nix
    # ./programs/bash.nix
    # ./programs/direnv.nix
    # ./programs/fish.nix
    # ./services/sketchybar.nix
    ./services/skhd.nix
    ./services/spotifyd.nix
    ./services/yabai.nix
  ];

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
      cleanup = "none";
    };
    taps = [
      # "homebrew/bundle",
      # "homebrew/services",
      # "mongodb/brew",
      # "shopify/shopify",
      # "ethereum/ethereum",
      # "aws/tap",
      # "dart-lang/dart",
      # "heroku/brew",
      # "sidneys/homebrew",
      # "tgotwig/linux-dust",
      # "leoafarias/fvm",
      # "clojure/tools",
      # "supabase/tap",
      # "planetscale/tap",
      # "planetscale/tap",
      # "tako8ki/tap",
      # "jesseduffield/lazygit",
      # "jesseduffield/lazydocker",
      # "coursier/formulas",
      # "charmbracelet/tap",
      # "cloudflare/cloudflare",
      # "borkdude/brew",
      # "arrow2nd/tap",
      # "teamookla/speedtest",
      # "d12frosted/emacs-plus",
      # "borkdude/brew",
      # "ngrok/ngrok",
      # "earthly/earthly",
      # "grishka/grishka",
      # "modularml/packages",
      # "symfony-cli/tap",
      # "cargo-lambda/cargo-lambda",
      # "FelixKratz/formulae",
    ];
    brews = [
      "bash"
      # "bash-completion"
      "gh"
      "mysql"
      "anyenv"
      # "llvm"
      "ninja"
      "rustup"
      "jq"
      "tmux"
      "tree"
      "cmake"
      # # "symfony-cli" no available formula
      # "ethereum"
      # "solidity"
      "clojure"
      "leiningen"
      # # "babashka" no available formula
      "sbcl"
      "stack"
      "go"
      # # "mongodb-community" no available formula
      "duck"
      "awscli"
      # "aws/tap/lightsailctl"
      "dart"
      # "sqlite"
      "tenv"
      "azure-cli"
      # # "themekit" no available formula
      "act"
      "hugo"
      # # "heroku" no available formula
      "tree-sitter"
      "emacs"
      # # "emacs-plus" args: ["with-spacemacs-icon" "with-native-comp"]
      "neovim"
      "lua"
      "luajit" # args: ["HEAD"]
      "luarocks"
      # "pure"
      "starship"
      "fzf"
      "eza"
      "bat"
      # "shpotify"
      "sl"
      "ffmpeg"
      "telnet"
      "nginx"
      "mkcert"
      # "aria2"
      "cabextract"
      # "wimlib"
      # "cdrtools"
      # # "sidneys/homebrew/chntpw" installation failed
      "kotlin"
      "nim"
      "pdfcrack"
      "hydra"
      "aircrack-ng"
      "hashcat"
      "youtube-dl"
      "yt-dlp"
      "mplayer"
      "pdf2svg"
      # # "supabase" no available formula
      # # "pscale" no available formula
      "cfonts"
      "pandoc"
      "fx"
      "arduino-cli"
      "neofetch"
      "caddy"
      "scala"
      "sbt"
      "fd"
      # "ripgrep"
      "pastel"
      "broot"
      # # "unixodbc"
      "tor" # restart_service: true
      "wget"
      "mas"
      "whalebrew"
      # # "fig"
      # "graphviz"
      # # "mono"
      # "gnucobol"
      # "git-delta"
      "gitui"
      "tokei"
      "helix"
      "kakoune"
      "genact"
      "onefetch"
      "bottom"
      "dust"
      "goreleaser"
      # "redis"
      "elixir"
      "jmeter"
      # "imagemagick"
      # "maven"
      "gradle"
      "testdisk"
      "duf"
      # # "dog" installation failed
      # "zplug"
      "lua-language-server"
      "httpie"
      "bandwhich"
      "wego"
      # # "gobang" no available formula
      "watchman"
      # "cocoapods"
      "streamlink"
      "git-secrets"
      "flyctl"
      "erlang"
      "ios-deploy"
      "jless"
      "elm"
      "lazygit"
      "lazydocker"
      # "ipfs" # ipfs/kubo
      "coursier"
      "gum"
      "vhs"
      "ttyd" # args: ["HEAD"]
      "cloudflared"
      "ghcup"
      "composer"
      "zola"
      "direnv"
      # # "fvm" no available formula
      "gpg"
      # # "clj-kondo" no available formula
      "minikube"
      # # "nekome" no available formula
      "qemu"
      # # "speedtest" no available formula
      # "golang-migrate"
      # # "ngrok" # install with cask
      # # "shopify-cli" no available formula
      # "wp-cli"
      "earthly"
      # "difftastic"
      "putty"
      "glow"
      "git-filter-repo"
      # "tnftp"
      "openssl"
      "ansible"
      "pipx"
      "lolcat"
      "hyperfine"
      "tldr"
      "zoxide"
      "procs"
      # "nushell"
      # # "vapor" # requires Xcode installed
      # "samba"
      "mist"
      "pkg-config"
      # "cairo"
      # "pango"
      # "libxslt"
      # "libiconv"
      # "libffi"
      # "libpng"
      # "libpq"
      # "jpeg"
      # "giflib"
      # "librsvg"
      # "pixman"
      # "smartmontools"
      "mpv"
      "ranger"
      "w3m"
      # "pipes-sh"
      # # "neardrop" installation failed
      # "portaudio"
      "monolith"
      # # "sapling"
      # # "modular" no available formula
      "pwgen"
      "xsv"
      "invoice"
      "skaffold"
      "kompose"
      # # "zed" no available formula
      # "grpc"
      "navi"
      # "bats-core"
      # # "getsentry/tools/sentry-cli" please tap
      "gibo"
      # # "cargo-lambda" no available formula
      "ggshield"
      # "cloudflare/cloudflare/cf-terraforming"
      "ollama"
      "sketchybar"
      "borders"
      "ghq"
      "mise"
    ];
    casks = [
      # # "1password" installed,
      # # "github" installed,
      # "chromium", args: { "no-quarantine": true },
      # "google-chrome",
      # "brave-browser",
      # "vivaldi",
      # "firefox",
      # "firefox@developer-edition",
      # "blisk",
      # "google-drive",
      # "dropbox",
      # "iterm2",
      # "kitty",
      # "hyper",
      # # "sourcetree",
      # "mamp",
      # "visual-studio-code",
      # "docker",
      # "blackhole-2ch",
      # "blackhole-16ch",
      # "blackhole-64ch",
      # "skype",
      # "discord",
      # "zoom",
      # "obs",
      # "appcleaner",
      # "postman",
      # "spotify",
      # "vlc",
      # "steam",
      # "sublime-text",
      # "lapce",
      # "gitify",
      # "jetbrains-toolbox",
      # "tor-browser",
      # "keycastr",
      # "1password/tap/1password-cli",
      # "webtorrent",
      # "numi",
      # "powershell",
      # "ubersicht",
      # # "dotnet",
      # "dotnet-sdk",
      # "wireshark",
      # "drawio",
      # # "google-japanese-ime" # Failed to install,
      # "alfred",
      # # "scenebuilder",
      # "blender",
      # "cyberduck",
      # "eqmac",
      # "figma",
      # "handbrake",
      # "imageoptim",
      # "min",
      # "minecraft",
      # # "mongodb-compass",
      # "notion",
      # "poedit",
      # "raspberry-pi-imager",
      # "sdformatter",
      # "unity-hub",
      # "ipfs" # ipfs/ipfs-desktop,
      # "local",
      # "microsoft-teams",
      # "vagrant",
      # "brewlet",
      # "xquartz",
      # "sf-symbols",
      # "onyx",
      # "burp-suite",
      # "azure-data-studio",
      # "audacity",
      # # "eclipse" similarly casks are available,
      # "tableplus",
      # "hammerspoon",
      # "mjml",
      # "termius",
      # "alacritty",
      # "wezterm",
      # "ghostty",
      # "arc",
      # "xbar",
      # "neovide",
      # "bartender",
      # "transmit",
      # "cloudflare-warp",
      # "diffusionbee",
      # "elgato-camera-hub",
      # "elgato-control-center",
      # "elgato-stream-deck",
      # "logi-options-plus",
      # "logitech-g-hub",
      # "obsidian",
      # "streamlabs",
      # "surge-xt",
      # "balenaetcher",
      # "bitcoin-core",
      # "whisky",
      # "epic-games",
      # "drivedx",
      # "xsplit-vcam",
      # "zulu@17",
      # "session-manager-plugin",
      # "chatgpt",
      # "background-music",
      # "alt-tab",
      # "lm-studio",
      # # "native-access",
    ];
    masApps = {
      # mas 'Messenger', id: 1480068668
      # mas 'LINE', id: 539883307
      # mas 'KakaoTalk', id: 869223134
      # mas 'Magnet', id: 441258766
      # mas 'Twitter', id: 1482454543
      # mas 'The Unarchiver', id: 425424353
      # mas 'DaisyDisk', id: 411643860
      # mas 'LanScan', id: 472226235
      # mas 'Spark', id: 1176895641
      # # mas 'Sequel Ace', id: 1518036000
      # mas 'Slack', id: 803453959
      # mas 'RunCat', id: 1429033973
      # mas 'PopClip', id: 445189367
      # mas 'Microsoft Word', id: 462054704
      # mas 'Microsoft Excel', id: 462058435
      # mas 'Microsoft PowerPoint', id: 462062816
      # mas 'Microsoft Outlook', id: 985367838
      # mas 'Tailscale', id: 1475387142
      # mas 'Kindle', id: 302584613
      # # mas 'Trello', id: 1278508951
      # # mas 'DaVinci Resolve', id: 571213070
      # # mas 'Final Cut Pro', id: 424389933
      # # mas 'Motion', id: 434290957
      # # mas 'Compressor', id: 424390742
      # # mas 'Logic Pro', id: 634148309
      # # mas 'MainStage', id: 634159523
    };
  };

  fonts = {
    packages = with pkgs; [
      # nerd-fonts-hack
      source-code-pro
      monocraft
    ];
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
