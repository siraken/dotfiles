{ pkgs, ... }:
let
  colors = import ../colors/tokyonight.nix;
in
{
  programs.lazygit = {
    enable = true;
    settings = {
      gui = {
        nerdFontsVersion = "3";
        theme = {
          activeBorderColor = [
            colors.orange
            "bold"
          ];
          inactiveBorderColor = [
            colors.ui.borderHighlight
          ];
          searchingActiveBorderColor = [
            colors.orange
            "bold"
          ];
          optionsTextColor = [
            colors.blue
          ];
          selectedLineBgColor = [
            colors.ui.bgSelection
          ];
          cherryPickedCommitFgColor = [
            colors.blue
          ];
          cherryPickedCommitBgColor = [
            colors.magenta
          ];
          markedBaseCommitFgColor = [
            colors.blue
          ];
          markedBaseCommitBgColor = [
            colors.yellow
          ];
          unstagedChangesColor = [
            colors.diagnostic.error
          ];
          defaultFgColor = [
            colors.ui.fg
          ];
        };
      };
    };
  };
}
