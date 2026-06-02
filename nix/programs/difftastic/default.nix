{ pkgs, ... }:
{
  # difftastic は CLI (`difft`) として導入するのみ。
  # git.enable を有効にすると diff.external が設定され `git diff` が
  # 常に difftastic になってしまうため無効化している。
  # `git diff` は組み込みのデフォルト diff を使い、difftastic は
  # 明示的に呼んだときだけ使う (git/default.nix の difftool/エイリアス参照)。
  programs.difftastic = {
    enable = true;
  };
}
