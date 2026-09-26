{
  config,
  pkgs,
  userProfile,
  ...
}:
let
  homeDir = config.users.users.${userProfile.username}.home;
  userPaths = import ../../modules/user-paths.nix { inherit homeDir; };
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

  customServices.postgresql = {
    enable = true;
    package = pkgs.postgresql_14;
    command = [
      "${pkgs.postgresql_14}/bin/postgres"
      "-D"
      (userPaths.data "postgresql")
    ];
    environment = {
      LC_ALL = "en_US.UTF-8";
      LANG = "en_US.UTF-8";
    };
  };
}
