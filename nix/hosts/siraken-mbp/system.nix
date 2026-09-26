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
