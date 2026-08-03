# AeroSpace のワークスペース一覧。
#
# AeroSpace の persistent-workspaces と Sketchybar のアイテム生成で共有する。
# Sketchybar はアイテムを起動時に作るため、実行時に `aerospace list-workspaces --all`
# を引くと「そのときウィンドウがあるワークスペース」しか拾えず、後から使い始めた
# 番号のアイテムが存在しないままになる。両者をこのリストから生成することで、
# ウィンドウの有無に関わらず同じ集合を見るようにしている。
#
# AeroSpace は home-manager、Sketchybar は nix-darwin と別のモジュール系にいるため、
# オプション経由ではなく素のデータとして import している。
[
  "1"
  "2"
  "3"
  "4"
  "5"
  "6"
  "7"
  "8"
  "9"
]
