{ pkgs-stable, ... }:
{
  programs.yt-dlp = {
    enable = true;
    package = pkgs-stable.yt-dlp;

    settings = {
      cookies-from-browser = "vivaldi";
    };
  };
}
