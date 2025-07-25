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
    # ../../services/sketchybar.nix
    ../../services/skhd.nix
    ../../services/spotifyd.nix
    ../../services/yabai.nix
    # ../../programs/tmux.nix
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
      # "homebrew/bundle"
      # "homebrew/services"
      # "mongodb/brew"
      # "shopify/shopify"
      # "ethereum/ethereum"
      # "aws/tap"
      # "dart-lang/dart"
      # "heroku/brew"
      # "sidneys/homebrew"
      # "tgotwig/linux-dust"
      # "leoafarias/fvm"
      # "clojure/tools"
      # "supabase/tap"
      # "planetscale/tap"
      # "planetscale/tap"
      # "tako8ki/tap"
      # "jesseduffield/lazygit"
      # "jesseduffield/lazydocker"
      # "coursier/formulas"
      # "charmbracelet/tap"
      # "cloudflare/cloudflare"
      # "borkdude/brew"
      # "arrow2nd/tap"
      # "teamookla/speedtest"
      # "d12frosted/emacs-plus"
      # "borkdude/brew"
      # "ngrok/ngrok"
      # "earthly/earthly"
      # "grishka/grishka"
      # "modularml/packages"
      # "symfony-cli/tap"
      # "cargo-lambda/cargo-lambda"
      # "FelixKratz/formulae"
      "VOICEVOX/voicevox"
    ];
    brews = [
      "act"
      "aircrack-ng"
      "ansible"
      "anyenv"
      "arduino-cli"
      "aria2"
      "awscli"
      "azure-cli"
      "bandwhich"
      "bash-completion"
      "bash"
      "bat"
      "bats-core"
      "borders"
      "bottom"
      "broot"
      "cabextract"
      "caddy"
      "cairo"
      "cdrtools"
      "cfonts"
      "clojure"
      "cloudflared"
      "cmake"
      "cocoapods"
      "composer"
      "coursier"
      "dart"
      "difftastic"
      "direnv"
      "duck"
      "duf"
      "dust"
      "earthly"
      "elixir"
      "elm"
      "emacs"
      "erlang"
      "ethereum"
      "eza"
      "fd"
      "ffmpeg"
      "flyctl"
      "fx"
      "fzf"
      "genact"
      "ggshield"
      "gh"
      "ghcup"
      "gibo"
      "giflib"
      "git-delta"
      "git-filter-repo"
      "git-secrets"
      "gitui"
      "glow"
      "gnucobol"
      "go"
      "goreleaser"
      "gpg"
      "gradle"
      "graphviz"
      "grpc"
      "gum"
      "hashcat"
      "helix"
      "httpie"
      "hugo"
      "hydra"
      "hyperfine"
      "imagemagick"
      "invoice"
      "ios-deploy"
      "jless"
      "jmeter"
      "jpeg"
      "jq"
      "kakoune"
      "kompose"
      "kotlin"
      "lazydocker"
      "lazygit"
      "leiningen"
      "libffi"
      "libiconv"
      "libpng"
      "libpq"
      "librsvg"
      "libxslt"
      "llvm"
      "lolcat"
      "lua-language-server"
      "lua"
      "luajit" # args: ["HEAD"]
      "luarocks"
      "mas"
      "maven"
      "minikube"
      "mise"
      "mist"
      "mkcert"
      "certbot"
      "monolith"
      "mplayer"
      "mpv"
      "mysql"
      "navi"
      "neofetch"
      "neovim"
      "nginx"
      "nim"
      "ninja"
      "ollama"
      "onefetch"
      "openssl"
      "pandoc"
      "pango"
      "pastel"
      "pdf2svg"
      "pdfcrack"
      "pipes-sh"
      "pipx"
      "pixman"
      "pkg-config"
      "portaudio"
      "procs"
      "pure"
      "putty"
      "pwgen"
      "qemu"
      "ranger"
      "redis"
      "ripgrep"
      "rustup"
      "samba"
      "sbcl"
      "sbt"
      "scala"
      "shpotify"
      "skaffold"
      "sketchybar"
      "sl"
      "smartmontools"
      "solidity"
      "sqlite"
      "stack"
      "streamlink"
      "telnet"
      "tenv"
      "testdisk"
      "tldr"
      "tnftp"
      "tokei"
      "tor" # restart_service: true
      "tree-sitter"
      "tree"
      "ttyd" # args: ["HEAD"]
      "vhs"
      "w3m"
      "watchman"
      "wego"
      "wget"
      "whalebrew"
      "wimlib"
      "xsv"
      "youtube-dl"
      "yt-dlp"
      "zola"
      "zoxide"
      "zplug"
      "pinact"
      "svn"
      # "aws/tap/lightsailctl"
      # "cloudflare/cloudflare/cf-terraforming"
      # "ipfs" # ipfs/kubo
      # # "babashka" no available formula
      # # "cargo-lambda" no available formula
      # # "clj-kondo" no available formula
      # # "dog" installation failed
      # # "emacs-plus" args: ["with-spacemacs-icon" "with-native-comp"]
      # # "fig"
      # # "fvm" no available formula
      # # "getsentry/tools/sentry-cli" please tap
      # # "gobang" no available formula
      # # "heroku" no available formula
      # # "modular" no available formula
      # # "mongodb-community" no available formula
      # # "mono"
      # # "neardrop" installation failed
      # # "nekome" no available formula
      # # "ngrok" # install with cask
      # # "pscale" no available formula
      # # "sapling"
      # # "shopify-cli" no available formula
      # # "sidneys/homebrew/chntpw" installation failed
      # # "speedtest" no available formula
      # # "supabase" no available formula
      # # "symfony-cli" no available formula
      # # "themekit" no available formula
      # # "unixodbc"
      # # "vapor" # requires Xcode installed
      # # "zed" no available formula
    ];
    casks = [
      # "1password"
      # "1password/tap/1password-cli"
      "alacritty"
      "alfred"
      "alt-tab"
      "appcleaner"
      "arc"
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
      "dotnet-sdk"
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
      # "ipfs-desktop" # ipfs/ipfs-desktop
      "iterm2"
      "jetbrains-toolbox"
      "keycastr"
      "kitty"
      "lapce"
      "lm-studio"
      "local"
      # FIXME: "logi-options+"
      # FIXME: "logi-options-plus"
      "logitech-g-hub"
      # "macfuse"
      "mamp"
      "microsoft-teams"
      "min"
      "minecraft"
      "mjml-app"
      "neovide-app"
      "notion"
      "numi"
      "obs"
      "obsidian"
      "onyx"
      "poedit"
      "postman"
      "powershell"
      "raspberry-pi-imager"
      "sdformatter"
      "session-manager-plugin"
      "sf-symbols"
      "skype"
      "sourcetree"
      "spotify"
      "steam"
      "streamlabs"
      "sublime-text"
      # "surge-xt"
      "tableplus"
      "termius"
      "tor-browser"
      "transmit"
      "ngrok"
      # "ubersicht"
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
      "youtube-music"
      "zoom"
      "zulu@17"
      "zed"
      # # "eclipse" similarly casks are available
      # # "google-japanese-ime" # Failed to install
      # # "mongodb-compass"
      # # "native-access"
      {
        name = "voicevox";
        args = { "no_quarantine" = true; };
      }
    ];
    masApps = {
      "Compressor" = 424390742;
      # "DaVinci Resolve" = 571213070;
      "Final Cut Pro" = 424389933;
      "Logic Pro" = 634148309;
      "MainStage" = 634159523;
      "Motion" = 434290957;
      # # "Sequel Ace" = 1518036000;
      # # "Trello" = 1278508951;
      "DaisyDisk" = 411643860;
      "KakaoTalk" = 869223134;
      "Kindle" = 302584613;
      "LanScan" = 472226235;
      "LINE" = 539883307;
      # "Magnet" = 441258766;
      "Messenger" = 1480068668;
      "Microsoft Excel" = 462058435;
      "Microsoft Outlook" = 985367838;
      "Microsoft PowerPoint" = 462062816;
      "Microsoft Word" = 462054704;
      "PopClip" = 445189367;
      # "RunCat" = 1429033973;
      "Slack" = 803453959;
      # "Spark" = 1176895641;
      # "Tailscale" = 1475387142;
      "The Unarchiver" = 425424353;
      # "Twitter" = 1482454543;
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
