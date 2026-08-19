{ pkgs, mkRepoLink, ... }:
{
  programs.wezterm = {
    # On darwin wezterm comes from the Homebrew cask, so only pull the nixpkgs
    # build on other platforms.
    enable = !pkgs.stdenv.hostPlatform.isDarwin;
  };

  # Mutable (out-of-store) symlink: edited in place, no rebuild required.
  home.file.".config/wezterm".source = mkRepoLink "config/wezterm";
}
