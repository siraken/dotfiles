# https://nix-darwin.github.io/nix-darwin/manual/index.html
{ pkgs, modulePath, ... }:
{
  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
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
    ./homebrew.nix
  ];

  system = {
    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    stateVersion = 5;

    defaults = {
      # TODO:
      # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -int 1
      # defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE
      # defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
      # defaults write com.jetbrains.PhpStorm ApplePressAndHoldEnabled -bool false
      # defaults write com.jetbrains.rubymine ApplePressAndHoldEnabled -bool false

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
    };
  };

  fonts = {
    packages = with pkgs; [ ];
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
