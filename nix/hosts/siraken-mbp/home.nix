{ ... }:
{
  imports = [
    ../../home/profiles/full.nix
    ../../home/profiles/darwin.nix
    # host-specific programs
    ../../programs/fastfetch
    ../../programs/herdr
    ../../programs/spotify-player
    # ../../programs/vscode
  ];

  home.stateVersion = "26.05";

  programs.yt-dlp.settings.cookies-from-browser = "chrome_canary";
}
