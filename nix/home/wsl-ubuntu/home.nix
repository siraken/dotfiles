{
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.stateVersion = "26.05";

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate =
        pkg:
        builtins.elem (lib.getName pkg) [
          "1password-cli"
        ];
    };
  };

  imports = [
    ../profiles/full.nix
    # inputs.dotfiles-private.homeManagerModules.default
    # host-specific programs
    ../../programs/fish
    ../../programs/spotify-player
    # ../../programs/difftastic
  ];

  nix = {
    package = pkgs.nix;
    settings = {
      extra-substituters = [
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://cache.numtide.com"
      ];
      extra-trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };
  };
}
