# OS side of the Hyprland desktop: compositor, greeter, lock screen, polkit
# agent. The user side (bar, launcher, notifications, the tools the bindings
# call) is nix/programs/hyprland, and the Hyprland config itself is
# config/hypr-nixos.
{ lib, pkgs, ... }:
{
  # Hyprland under UWSM, so each app and session service runs as its own
  # systemd user unit.
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # /home is shared with Omarchy until it is removed, and ~/.config/hypr is
  # still Omarchy's (config/hypr). Point Hyprland at the NixOS config instead;
  # pam_env sets this for the greetd session only on this system.
  environment.sessionVariables.HYPRLAND_CONFIG = "$HOME/.config/hypr-nixos/hyprland.lua";

  services.greetd = {
    enable = true;
    settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-uwsm.desktop'";
  };

  # Its PAM service, and hypridle as a NixOS user unit (not in the shared
  # ~/.config/systemd/user), which locks with it.
  programs.hyprlock.enable = true;
  # The unit reads ~/.config/hypr/hypridle.conf (Omarchy's directory) by
  # default.
  systemd.user.services.hypridle.serviceConfig.ExecStart = [
    ""
    "${lib.getExe pkgs.hypridle} -c %h/.config/hypr-nixos/hypridle.conf"
  ];

  # A NixOS user unit, not home-manager's: ~/.config/systemd/user is shared
  # with Omarchy, which runs its own agent.
  systemd.user.services.hyprpolkitagent = {
    description = "Hyprland polkit authentication agent";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
      Restart = "on-failure";
    };
  };

  # Bluetooth manager (D-Bus service and applet) for the bar's bluetooth module.
  services.blueman.enable = true;

  # Mount removable drives from the file manager.
  services.gvfs.enable = true;
  services.udisks2.enable = true;
}
