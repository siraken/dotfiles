# https://nix-darwin.github.io/nix-darwin/manual/index.html
{ pkgs, modulePath, ... }:
let
  networkingHostName = "Kentos-Darwin-Min";
in
{
  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    # The platform the configuration will be used on.
    hostPlatform = "aarch64-darwin";

    # Allow unfree packages
    config.allowUnfree = true;
  };

  networking = {
    hostName = networkingHostName;
    localHostName = networkingHostName;
  };

  environment = {
    shells = import ../../modules/shells.nix { inherit pkgs; };
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
      # TODO:
      # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
      NSGlobalDomain = {
        NSWindowShouldDragOnGesture = true;
        "com.apple.mouse.tapBehavior" = 1; # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
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
          watchIdAuth = false; # TODO: nixpkgs Swift build issue
        };
      };
    };
  };

  services = { };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "none";
    };
    taps = [
      "siraken/homebrew-tap"
      "novalumo/homebrew-tap"
    ];
    brews = [
      "ansible"
      "cloudflared"
    ];
    casks = [
      "alt-tab"
      "appcleaner"
      "arc"
      "brave-browser"
      "drivedx"
      "google-chrome"
      "visual-studio-code"
      "vivaldi"
      "raycast"
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
}
