{ pkgs, ... }:
{
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      hidpi = "off";
      width = 8.0;
      active_color = "0xffffffff";
      inactive_color = "0x00000000";
      background_color = "0x00000000";
    };
  };
}
