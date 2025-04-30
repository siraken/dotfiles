# https://nix-darwin.github.io/nix-darwin/manual/index.html
{ pkgs, modulePath, ... }:
{
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment = {
    systemPackages = with pkgs; [
      vim
      nixfmt-rfc-style
    ];
  };

  nix = {
    # Necessary for using flakes on this system.
    settings.experimental-features = "nix-command flakes";
  };

  imports = [
    # ./programs/bash.nix
    # ./programs/direnv.nix
    # ./programs/fish.nix
    # ./services/sketchybar.nix
    ./services/skhd.nix
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

  fonts = {
    packages = with pkgs; [ ];
  };

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
