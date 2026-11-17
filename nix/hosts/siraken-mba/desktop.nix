# OS side of the Hyprland desktop: compositor, greeter, lock screen, polkit
# agent. The user side (bar, launcher, notifications, the tools the bindings
# call) is nix/programs/hyprland, and the Hyprland config itself is
# config/hypr-nixos.
{
  lib,
  pkgs,
  userProfile,
  ...
}:
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
  environment.sessionVariables = {
    HYPRLAND_CONFIG = "$HOME/.config/hypr-nixos/hyprland.lua";
    # Omarchy's ~/.XCompose includes a file under /usr/share/omarchy, which
    # does not exist here: xkbcommon then has no compose table and WezTerm
    # panics ("no keymap"). Use the locale's default instead until #244.
    XCOMPOSEFILE = "$HOME/.config/hypr-nixos/XCompose";
  };

  services.greetd = {
    enable = true;
    settings = {
      # The disk is encrypted, so the LUKS passphrase already proves who is at
      # the machine: log in once after boot without asking again, as Omarchy
      # did. hyprlock still asks after suspend and idle.
      initial_session = {
        user = userProfile.username;
        command = "uwsm start hyprland-uwsm.desktop";
      };
      # After logging out.
      default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --cmd 'uwsm start hyprland-uwsm.desktop'";
    };
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

  # Secret Service for gh, browsers and the like. The keyring itself
  # (~/.local/share/keyrings) is the one Omarchy created, without a password,
  # so it opens without one after the automatic login too. greetd's PAM stack
  # includes login's, which starts the daemon.
  services.gnome.gnome-keyring.enable = true;
}
