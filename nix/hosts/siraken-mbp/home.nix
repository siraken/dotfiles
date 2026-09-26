{ ... }:
{
  imports = [
    ../../home/profiles/full.nix
    ../../home/profiles/darwin.nix
    # host-specific programs
    ../../programs/fastfetch
    ../../programs/fish
    ../../programs/herdr
    # ../../programs/spotify-player # disabled: nixpkgs linker crash (cctools-binutils-darwin)
    # ../../programs/vscode
  ];

  home.stateVersion = "26.05";

  programs.yt-dlp.settings.cookies-from-browser = "chrome_canary";
}
