# User side of the Hyprland desktop on NixOS (siraken-mba): the tools its
# bindings call and their native config. Hyprland itself, the greeter, the
# lock screen's PAM service and the polkit agent are the OS layer's
# (nix/hosts/siraken-mba/desktop.nix).
#
# The session services start from config/hypr/autostart.lua rather than as
# home-manager units.
{ pkgs, mkRepoLink, ... }:
{
  imports = [
    ./colors.nix
    ./theme.nix
  ];

  home.packages = with pkgs; [
    waybar
    fuzzel
    swaynotificationcenter
    swayosd
    wlogout
    hyprpaper
    libnotify
    hyprpicker
    hyprsunset
    grim
    slurp
    # Annotating screenshots and recording (scripts/screenshot, scripts/record).
    satty
    wf-recorder
    jq
    wl-clipboard
    cliphist
    # Emoji menu (scripts/menu): rofimoji types with wtype.
    rofimoji
    wtype
    playerctl
    # Panels from the bar (scripts/panel); the GTK apps stay on right-click.
    wiremix
    bluetui
    wifitui
    pavucontrol
    networkmanagerapplet
    nautilus
    # Symbolic icons swayosd and GTK dialogs ask for by name.
    adwaita-icon-theme
    xdg-user-dirs
    btop
    # Fallback terminal (SUPER + ALT + RETURN), and the one the bar's panels
    # open in (config/foot).
    foot
  ];

  # No blueman or nm-applet in the tray: the bar has Bluetooth and network
  # already, and opens blueman-manager / nm-connection-editor on right-click.
  xdg.configFile = {
    "autostart/blueman.desktop".text = "[Desktop Entry]\nHidden=true\n";
    "autostart/nm-applet.desktop".text = "[Desktop Entry]\nHidden=true\n";
  };

  home.file.".config/hypr".source = mkRepoLink "config/hypr";
  home.file.".config/waybar".source = mkRepoLink "config/waybar";
  home.file.".config/swaync".source = mkRepoLink "config/swaync";
  home.file.".config/swayosd".source = mkRepoLink "config/swayosd";
  home.file.".config/wlogout".source = mkRepoLink "config/wlogout";
  home.file.".config/fuzzel".source = mkRepoLink "config/fuzzel";
  home.file.".config/foot".source = mkRepoLink "config/foot";
}
