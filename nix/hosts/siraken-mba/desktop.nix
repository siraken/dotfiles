# OS side of the Hyprland desktop: compositor, greeter, lock screen, polkit
# agent. The user side (bar, launcher, notifications, the tools the bindings
# call) is nix/programs/hyprland, and the Hyprland config itself is
# config/hypr.
{
  pkgs,
  userProfile,
  ...
}:
let
  tokyonight = import ../../colors/tokyonight.nix;
in
{
  # Hyprland under UWSM, so each app and session service runs as its own
  # systemd user unit.
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  environment.sessionVariables = {
    # Electron and Chromium apps (Discord, Obsidian, Spotify, …) as native
    # Wayland windows.
    NIXOS_OZONE_WL = "1";
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
      # After logging out, ReGreet (below) is the greeter.
    };
  };

  # ReGreet preselects the session it last started, and the first one listed
  # otherwise: plain "Hyprland", without UWSM, which autostart.lua and the
  # bindings (uwsm-app) rely on. Seed its state once; it keeps it up to date.
  systemd.tmpfiles.settings.regreet."/var/lib/regreet/state.toml".f = {
    user = "greeter";
    group = "greeter";
    mode = "0644";
    argument = "last_user = \"${userProfile.username}\"\n\n[user_to_last_sess]\n${userProfile.username} = \"Hyprland (uwsm-managed)\"\n";
  };

  # The greeter after a log out, in the desktop's colours. It runs as the
  # greeter user, which cannot read /home, so no wallpaper.
  services.displayManager.regreet = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };
    font = {
      name = "Hack Nerd Font";
      package = pkgs.nerd-fonts.hack;
      size = 12;
    };
    settings = {
      GTK.application_prefer_dark_theme = true;
      appearance.greeting_msg = "Welcome back";
      widget.clock.format = "%a %m/%d  %H:%M";
    };
    extraCss = with tokyonight; ''
      window {
        background-color: ${ui.bg};
      }

      frame,
      box.background {
        background-color: ${ui.bg};
        border: 1px solid #2f3549;
        border-radius: 8px;
      }

      button.suggested-action {
        background: ${blue};
        color: ${ui.bg};
      }

      label {
        color: ${white};
      }
    '';
  };

  # Its PAM service, and hypridle as a NixOS user unit reading
  # ~/.config/hypr/hypridle.conf, which locks with it.
  programs.hyprlock.enable = true;

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

  # Secret Service for gh, browsers and the like. The default keyring
  # (~/.local/share/keyrings, created on Omarchy) has no password, so it opens
  # after the automatic login too. greetd's PAM stack includes login's, which
  # starts the daemon.
  services.gnome.gnome-keyring.enable = true;
}
