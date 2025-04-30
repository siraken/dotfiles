# https://nix-darwin.github.io/nix-darwin/manual/index.html
{ pkgs, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      vim
    ];
  };

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  # Enable alternative shell support in nix-darwin.
  # programs.fish.enable = true;

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    defaults = {
      # TODO:
      # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
      # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

      dock = {
        orientation = "bottom";
        tilesize = 40;
        autohide = true;
        autohide-time-modifier = 0.5;
        autohide-delay = 0.2;
        show-recents = true;
        mineffect = "scale";
        static-only = false;
        scroll-to-open = false;
      };
      finder = {
        AppleShowAllExtensions = false;
        AppleShowAllFiles = false;
      };
    };
  };

  services = {
    skhd = {
      enable = true;
      # Modifiers:
      #  - fn: function key
      #  - cmd: command key
      #  - alt: option key
      #  - ctrl: control key
      #  - shift: shift key
      #  - hyper: cmd + shift + alt + ctrl
      #  - meh: shift + alt + ctrl
      skhdConfig = ''
      # focus window
      shift + alt - h : yabai -m window --focus west || yabai -m display --focus west
      shift + alt - j : yabai -m window --focus south || yabai -m display --focus south
      shift + alt - k : yabai -m window --focus north || yabai -m display --focus north
      shift + alt - l : yabai -m window --focus east || yabai -m display --focus east

      # move window
      ctrl + cmd - h : yabai -m window --warp west || (yabai -m window --display west; yabai -m display --focus west)
      ctrl + cmd - j : yabai -m window --warp south || (yabai -m window --display south; yabai -m display --focus south)
      ctrl + cmd - k : yabai -m window --warp north || (yabai -m window --display north; yabai -m display --focus north)
      ctrl + cmd - l : yabai -m window --warp east || (yabai -m window --display east; yabai -m display --focus east)

      # rotate tree
      alt - r : yabai -m space --rotate 90

      # invert tree x-axis
      alt - x : yabai -m space --mirror x-axis

      # invert tree y-axis
      alt - y : yabai -m space --mirror y-axis

      # toggle window fullscreen zoom
      alt - f : yabai -m window --toggle zoom-fullscreen

      # toggle window split type
      alt - e : yabai -m window --toggle split

      # float / unfloat window and restore position
      # alt - t : yabai -m window --toggle float && /tmp/yabai-restore/$(yabai -m query --windows --window | jq -re '.id').restore 2>/dev/null || true
      alt - t : yabai -m window --toggle float --grid 4:4:1:1:2:2

      # toggle picture-in-picture
      alt - p : yabai -m window --toggle border --toggle pip
      '';
    };

    yabai = {
      enable = true;
      config = {
        mouse_follows_focus = "off";
        focus_follows_mouse = "off";
        window_origin_display = "default";
        window_placement = "second_child";
        window_zoom_persist = "on";
        window_topmost = "off";
        window_shadow = "on";
        window_animation_duration = 0.0;
        window_animation_frame_rate = 120;
        window_opacity_duration = 0.0;
        active_window_opacity = 1.0;
        normal_window_opacity = 0.50;
        window_opacity = "off";
        insert_feedback_color = "0xffd75f5f";
        active_window_border_color = "0xff775759";
        normal_window_border_color = "0xff555555";
        window_border_width = 4;
        window_border_radius = 12;
        window_border_blur = "off";
        window_border_hidpi = "on";
        window_border = "off";
        split_ratio = 0.50;
        split_type = "auto";
        auto_balance = "off";
        external_bar = "all:32:0";
        top_padding = 12;
        bottom_padding = 12;
        left_padding = 12;
        right_padding = 12;
        window_gap = 6;
        layout = "bsp";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        mouse_drop_action = "swap";
      };
      extraConfig = ''
      # macOS Utilities
      yabai -m rule --add app=Finder manage=off
      yabai -m rule --add app=Stickies manage=off
      yabai -m rule --add app=System\ Preferences manage=off
      yabai -m rule --add app=System\ Settings manage=off
      yabai -m rule --add app=Activity\ Monitor manage=off
      yabai -m rule --add app=Console manage=off
      yabai -m rule --add app=Screen\ Sharing manage=off
      yabai -m rule --add app=Preview manage=off
      yabai -m rule --add app=Photos manage=off
      yabai -m rule --add app=QuickTime\ Player manage=off
      yabai -m rule --add app=Messages manage=off
      yabai -m rule --add app=Feedback\ Assistant manage=off
      yabai -m rule --add app=Xcode manage=off
      yabai -m rule --add app=Final\ Cut\ Pro manage=off
      yabai -m rule --add app=Motion manage=off
      yabai -m rule --add app=Logic\ Pro manage=off
      yabai -m rule --add app=Disk\ Utility manage=off

      # macOS iWork
      yabai -m rule --add app=Pages manage=off
      yabai -m rule --add app=Numbers manage=off
      yabai -m rule --add app=Keynote manage=off

      # Microsoft Office
      yabai -m rule --add app=Word manage=off
      yabai -m rule --add app=Excel manage=off
      yabai -m rule --add app=PowerPoint manage=off
      # yabai -m rule --add app=OneNote manage=off
      # yabai -m rule --add app=Outlook manage=off
      # yabai -m rule --add app=Microsoft\ Teams manage=off
      yabai -m rule --add app=Microsoft\ Remote\ Desktop manage=off

      # Utilities
      yabai -m rule --add app=1Password manage=off
      yabai -m rule --add app=DiffusionBee manage=off
      yabai -m rule --add app=balenaEtcher manage=off
      yabai -m rule --add app=Alfred\ Preferences manage=off
      yabai -m rule --add app=DaisyDisk manage=off
      yabai -m rule --add app=VMware\ Fusion manage=off
      yabai -m rule --add app=HYPERSBI2 manage=off

      # Adobe
      yabai -m rule --add app=Adobe\ Photoshop\ 2023 manage=off
      yabai -m rule --add app=Adobe\ Illustrator\ 2023 manage=off
      yabai -m rule --add app=Adobe\ Premiere\ Pro\ 2023 manage=off
      yabai -m rule --add app=Adobe\ After\ Effects\ 2023 manage=off
      yabai -m rule --add app=Adobe\ XD manage=off
      yabai -m rule --add app=Adobe\ Lightroom manage=off

      # Design
      yabai -m rule --add app=Pixelmator\ Pro manage=off
      yabai -m rule --add app=Figma manage=off
      yabai -m rule --add app=Blender manage=off

      # Music
      yabai -m rule --add app=Studio\ One\ 5 manage=off

      # Video
      yabai -m rule --add app=DaVinci\ Resolve manage=off
      yabai -m rule --add app=OBS manage=off

      # Browsers
      # yabai -m rule --add app=Google\ Chrome manage=off
      # yabai -m rule --add app=Firefox manage=off
      # yabai -m rule --add app=Firefox\ Developer\ Edition manage=off
      # yabai -m rule --add app=Brave\ Browser manage=off
      # yabai -m rule --add app=Vivaldi manage=off
      # yabai -m rule --add app=Safari manage=off
      # yabai -m rule --add app=Blisk manage=off
      # yabai -m rule --add app=Microsoft\ Edge manage=off
      # yabai -m rule --add app=Tor\ Browser manage=off

      # Development
      yabai -m rule --add app=TablePlus manage=off
      yabai -m rule --add app=Transmit manage=off
      yabai -m rule --add app=GitHub\ Desktop manage=off
      yabai -m rule --add app=Sourcetree manage=off
      yabai -m rule --add app=Docker\ Desktop manage=off
      yabai -m rule --add app=Sublime\ Text manage=off
      yabai -m rule --add app=WebTorrent manage=off
      # yabai -m rule --add app=iTerm2 manage=off
      # yabai -m rule --add app=Visual\ Studio manage=off

      # Communication
      # yabai -m rule --add app=zoom.us manage=off
      yabai -m rule --add app=Spark manage=off
      yabai -m rule --add app=Slack manage=off
      yabai -m rule --add app=Discord manage=off

      # Streaming
      yabai -m rule --add app=Spotify manage=off

      # Security
      yabai -m rule --add app=ESET\ Endpoint\ Security manage=off

      # Games
      yabai -m rule --add app=Steam manage=off
      yabai -m rule --add app=Riot\ Client manage=off
      yabai -m rule --add app=League\ of\ Legends manage=off
      yabai -m rule --add app=League\ Of\ Legends manage=off
      '';
    };
  };

  fonts = {
    packages = with pkgs; [];
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
      # "sass/sass",
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
      # "oven-sh/bun",
      # "grishka/grishka",
      # "modularml/packages",
      # "symfony-cli/tap",
      # "cargo-lambda/cargo-lambda",
      # "FelixKratz/formulae",
    ];
    brews = [
      # "bash",
      # "bash-completion",
      # "gh",
      # "volta",
      # "deno",
      # "mysql",
      # "anyenv",
      # "llvm",
      # "ninja",
      # "rustup",
      # "pyenv",
      # "rbenv",
      # "jq",
      # "tmux",
      # "tree",
      # "cmake",
      # # "symfony-cli" no available formula,
      # "ethereum",
      # "solidity",
      # "clojure",
      # "leiningen",
      # # "babashka" no available formula,
      # "sbcl",
      # "stack",
      # "go",
      # # "mongodb-community" no available formula,
      # # "sass" no available formula,
      # "duck",
      # "awscli",
      # "aws/tap/lightsailctl",
      # "dart",
      # "sqlite",
      # "tenv",
      # "azure-cli",
      # # "themekit" no available formula,
      # "act",
      # "hugo",
      # # "heroku" no available formula,
      # "tree-sitter",
      # "emacs",
      # # "emacs-plus", args: ["with-spacemacs-icon", "with-native-comp"],
      # "neovim",
      # "lua",
      # "luajit", args: ["HEAD"],
      # "luarocks",
      # "pure",
      # "starship",
      # "fzf",
      # "eza",
      # "bat",
      # "shpotify",
      # "sl",
      # "ffmpeg",
      # "telnet",
      # "nginx",
      # "mkcert",
      # "aria2",
      # "cabextract",
      # "wimlib",
      # "cdrtools",
      # # "sidneys/homebrew/chntpw" installation failed,
      # "kotlin",
      # "nim",
      # "pdfcrack",
      # "hydra",
      # "aircrack-ng",
      # "hashcat",
      # "youtube-dl",
      # "yt-dlp",
      # "mplayer",
      # "pdf2svg",
      # # "supabase" no available formula,
      # # "pscale" no available formula,
      # "cfonts",
      # "pandoc",
      # "fx",
      # "arduino-cli",
      # "zig",
      # "neofetch",
      # "caddy",
      # "scala",
      # "sbt",
      # "fd",
      # "ripgrep",
      # "pastel",
      # "broot",
      # # "unixodbc",
      # "tor", restart_service: true,
      # "wget",
      # "mas",
      # "whalebrew",
      # # "fig",
      # "graphviz",
      # # "mono",
      # "gnucobol",
      # "git-delta",
      # "gitui",
      # "tokei",
      # "helix",
      # "kakoune",
      # "genact",
      # "onefetch",
      # "bottom",
      # "dust",
      # "goreleaser",
      # "redis",
      # "elixir",
      # "jmeter",
      # "imagemagick",
      # "maven",
      # "gradle",
      # "testdisk",
      # "duf",
      # # "dog" installation failed,
      # "zplug",
      # "lua-language-server",
      # "httpie",
      # "bandwhich",
      # "wego",
      # # "gobang" no available formula,
      # "watchman",
      # "cocoapods",
      # "streamlink",
      # "git-secrets",
      # "flyctl",
      # "erlang",
      # "ios-deploy",
      # "jless",
      # "elm",
      # "lazygit",
      # "lazydocker",
      # "ipfs" # ipfs/kubo,
      # "coursier",
      # "gum",
      # "vhs",
      # "ttyd", args: ["HEAD"],
      # "cloudflared",
      # "ghcup",
      # "composer",
      # "zola",
      # "direnv",
      # # "fvm" no available formula,
      # "gpg",
      # # "clj-kondo" no available formula,
      # "minikube",
      # # "nekome" no available formula,
      # "qemu",
      # # "speedtest" no available formula,
      # "golang-migrate",
      # # "ngrok" # install with cask,
      # # "shopify-cli" no available formula,
      # "wp-cli",
      # "earthly",
      # "difftastic",
      # "putty",
      # "glow",
      # "git-filter-repo",
      # "tnftp",
      # "openssl",
      # "ansible",
      # "pipx",
      # "lolcat",
      # "hyperfine",
      # "tldr",
      # "zoxide",
      # "procs",
      # "nushell",
      # # "vapor" # requires Xcode installed,
      # "samba",
      # "mist",
      # "pkg-config",
      # "cairo",
      # "pango",
      # "libxslt",
      # "libiconv",
      # "libffi",
      # "libpng",
      # "libpq",
      # "jpeg",
      # "giflib",
      # "librsvg",
      # "pixman",
      # "smartmontools",
      # "mpv",
      # "ranger",
      # "w3m",
      # "pipes-sh",
      # # "bun" no available formula,
      # # "neardrop" installation failed,
      # "portaudio",
      # "monolith",
      # # "sapling",
      # # "modular" no available formula,
      # "pwgen",
      # "xsv",
      # "invoice",
      # "skaffold",
      # "kompose",
      # # "zed" no available formula,
      # "grpc",
      # "navi",
      # "bats-core",
      # # "getsentry/tools/sentry-cli" please tap,
      # "gibo",
      # # "cargo-lambda" no available formula,
      # "asdf",
      # "ggshield",
      # "cloudflare/cloudflare/cf-terraforming",
      # "ollama",
      # "sketchybar",
      # "borders",
      # "ghq",
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
      # "font-hack-nerd-font",
      # "font-monocraft",
      # "font-source-code-pro",
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

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
