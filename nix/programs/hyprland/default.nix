# User side of the Hyprland desktop on NixOS (siraken-mba): the tools its
# bindings call, the session services and their native config. Hyprland
# itself, the greeter, hypridle and the lock screen's PAM service are the OS
# layer's (nix/hosts/siraken-mba/desktop.nix).
#
# The session services are systemd user units under graphical-session.target,
# which UWSM starts with the session: restarted when they crash, logged with
# `journalctl --user -u <name>`, and stopped on logout.
{ pkgs, mkRepoLink, ... }:
{
  imports = [
    ./colors.nix
    ./theme.nix
  ];

  home.packages = with pkgs; [
    fuzzel
    swaynotificationcenter
    wlogout
    libnotify
    hyprpicker
    grim
    slurp
    # Annotating screenshots and recording (scripts/screenshot, scripts/record).
    satty
    wf-recorder
    jq
    wl-clipboard
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

  # Config files are the repo's (config/waybar, config/hypr/hyprpaper.conf,
  # config/hypr/hyprsunset.conf, config/swayosd): no settings here, so the
  # modules write none.
  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };
  services.swayosd.enable = true;
  # GTK's Vulkan renderer is incomplete on Haswell; GL draws the OSD fine.
  systemd.user.services.swayosd.Service.Environment = [ "GSK_RENDERER=gl" ];
  services.hyprpaper.enable = true;
  # The night light on a schedule; scripts/nightlight toggles it over IPC.
  services.hyprsunset.enable = true;
  services.cliphist = {
    enable = true;
    allowImages = true;
  };
  services.hyprpolkitagent.enable = true;

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
