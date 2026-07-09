{ pkgs, ... }:
{
  home.packages = [
    (pkgs.writeShellScriptBin "gco" ''
      branch=$(git branch --all | sed 's/^[* ]*//' | fzf)
      if [ -n "$branch" ]; then
        git checkout "$(echo "$branch" | sed 's#remotes/origin/##')"
      fi
    '')

    (pkgs.writeShellScriptBin "gd-select" ''
      ghq list -p | fzf
    '')
  ];
}
