# One look for the toolkits around the Hyprland desktop, matching the Tokyo
# Night bar: dark GTK and Qt, Papirus icons, the Bibata cursor.
#
# GTK reads the color scheme from dconf, which is shared with Omarchy until
# #244 (Omarchy set the same prefer-dark there).
{ pkgs, ... }:
let
  cursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
  };
in
{
  home.pointerCursor = cursor // {
    enable = true;
    gtk.enable = true;
    # Hyprland itself takes XCURSOR_THEME / XCURSOR_SIZE from envs.lua.
    x11.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    font = {
      name = "Noto Sans";
      size = 10;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";
    gtk-theme = "Adwaita-dark";
    icon-theme = "Papirus-Dark";
    cursor-theme = cursor.name;
    cursor-size = cursor.size;
    # GTK4 / libadwaita apps read these; their default, Adwaita Sans, is not
    # installed.
    font-name = "Noto Sans 10";
    monospace-font-name = "Hack Nerd Font Mono 10";
  };

  qt = {
    enable = true;
    platformTheme.name = "adwaita";
    style.name = "adwaita-dark";
  };
}
