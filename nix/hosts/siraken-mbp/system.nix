{
  config,
  userProfile,
  ...
}:
let
  homeDir = config.users.users.${userProfile.username}.home;
in
{
  imports = [
    ../../modules/darwin/launchd-services.nix
  ];

  # The two external displays at the desk each get a fixed workspace. Without
  # this, every persistent workspace (1-9) lives on the main display, so at
  # startup AeroSpace gives each external display a fresh stub workspace
  # numbered after the persistent ones (10, 11), which Sketchybar never shows.
  # When a display is absent (away from the desk) its workspace falls back to
  # the main display.
  services.aerospace.settings.workspace-to-monitor-force-assignment = {
    "8" = "^LCD-GC243HXD$"; # left
    "9" = "^LCD-GC271X$"; # right
  };

  system.defaults.dock = {
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
    persistent-apps = [
      "/Applications/Google Chrome.app"
      "/Applications/Google Chrome Canary.app"
      "/Applications/Spark Desktop.app"
      "/Applications/Slack.app"
      "/Applications/Discord.app"
      "/Applications/Obsidian.app"
      "/Applications/Spotify.app"
    ];
    persistent-others = [
      {
        folder = {
          path = "${homeDir}/Downloads";
          arrangement = "date-added";
          displayas = "folder";
          showas = "grid";
        };
      }
    ];
  };
}
