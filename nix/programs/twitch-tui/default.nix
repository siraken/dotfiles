{ pkgs, ... }:
{
  programs.twitch-tui = {
    enable = true;
    settings = {
      # FIXME: This is an example configuration. Customize as needed.
      # terminal = {
      #   delay = 30;
      #   first_state = "dashboard";
      #   log_file = "";
      #   log_level = "info";
      #   maximum_messages = 500;
      # };
      # twitch = {
      #   channel = "";
      #   server = "wss://eventsub.wss.twitch.tv/ws";
      #   token = "";
      #   username = "";
      # };
    };
  };
}
