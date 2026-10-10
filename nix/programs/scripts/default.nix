{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "gco" (builtins.readFile ./gco.sh))

    (pkgs.writeShellScriptBin "gd-select" (builtins.readFile ./gd-select.sh))

    (pkgs.writeShellApplication {
      name = "gau";
      runtimeInputs = with pkgs; [
        coreutils
        git
      ];
      text = builtins.readFile ./gau.sh;
    })

    (pkgs.writeShellApplication {
      name = "nix-cache-push";
      runtimeInputs = with pkgs; [
        cachix
        coreutils
        curl
        findutils
        gawk
        gnugrep
        gnused
        nix
      ];
      text = builtins.readFile ./nix-cache-push.sh;
    })
  ];
}
