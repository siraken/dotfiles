# User side of the Hyprland desktop on NixOS (siraken-mba): the tools its
# bindings call and their native config. Hyprland itself, the greeter, the
# lock screen's PAM service and the polkit agent are the OS layer's
# (nix/hosts/siraken-mba/desktop.nix).
#
# Nothing here is a systemd user unit or a home-manager service module:
# ~/.config is shared with the Omarchy install until it is removed, so
# config/hypr-nixos/autostart.lua starts these from Hyprland instead.
{ pkgs, mkRepoLink, ... }:
{
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
    jq
    wl-clipboard
    cliphist
    playerctl
    pavucontrol
    networkmanagerapplet
    nautilus
    # Icons for the tray (fcitx5, nm-applet) and GTK apps.
    adwaita-icon-theme
    xdg-user-dirs
    btop
    # Fallback terminal (SUPER + ALT + RETURN); reads Omarchy's
    # ~/.config/foot while /home is shared.
    foot
  ];

  # Read through HYPRLAND_CONFIG, not ~/.config/hypr (still Omarchy's).
  home.file.".config/hypr-nixos".source = mkRepoLink "config/hypr-nixos";
  home.file.".config/waybar".source = mkRepoLink "config/waybar";
  home.file.".config/swaync".source = mkRepoLink "config/swaync";
  home.file.".config/swayosd".source = mkRepoLink "config/swayosd";
  home.file.".config/wlogout".source = mkRepoLink "config/wlogout";
  home.file.".config/fuzzel".source = mkRepoLink "config/fuzzel";
}
