{ pkgs, ... }:
{
  programs.yt-dlp = {
    enable = true;
    package = pkgs.yt-dlp;

    settings = {
      cookies-from-browser = "vivaldi";
    };
  };
}
