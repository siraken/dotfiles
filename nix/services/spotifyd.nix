{ pkgs, ... }:
{
  services.spotifyd = {
    enable = true;
    settings = {
      username = "siraken";
      use_keyring = true;
      device_name = "spotifyd @ Kento's MacBook Pro";
      device_type = "computer";
      bitrate = 320;
      initial_volume = 100;
    };
  };
}
