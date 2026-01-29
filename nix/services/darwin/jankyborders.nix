{ pkgs, ... }:
{
  services.jankyborders = {
    enable = true;
    settings = {
      style = "round";
      hidpi = "off";
      width = 5.0;
      # active_color = "0xffe1e3e4";
      active_color = "0x55ffffff";
      inactive_color = "0x55494d64";
    };
  };
}
