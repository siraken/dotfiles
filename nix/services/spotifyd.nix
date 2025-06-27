{ pkgs, ... }:
{
  services.spotifyd = {
    enable = true;
    settings = {
      username = "siraken";
      use_keyring = true;
      device_name = "spotifyd @ Kento's MacBook Pro";
      device_type = "computer";
      device = "default";
      bitrate = 320;
      backend = "portaudio";
      initial_volume = 100;
      volume_controller = "softvol";
    };
  };
}
