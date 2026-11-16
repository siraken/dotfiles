{ ... }:
{
  imports = [
    # standard rather than full to keep this 8 GB machine light, plus the
    # coding agents from full.
    ../../home/profiles/standard.nix
    ../../modules/home/nixos-host.nix
    ../../programs/coding-agents
    ../../programs/wezterm
  ];

  # The repo is checked out at ~/dotfiles, as on the daily drivers.
  dotfiles.linkMode = "outOfStore";

  home.stateVersion = "26.11";
}
