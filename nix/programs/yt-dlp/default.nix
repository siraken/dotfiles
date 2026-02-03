{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;

    settings = {
      cookies-from-browser = "vivaldi";
    };
  };
}
