# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## コマンド

### 環境構築

```bash
# Nixをインストール
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

# nix-darwinをインストール
nix run nix-darwin/nix-darwin-25.05#darwin-rebuild -- switch --flake .

# システム構成をビルド・適用
sudo darwin-rebuild build --flake .#mbp
sudo darwin-rebuild switch --flake .#mbp

# ガベージコレクション
nix store gc
```

### dotfilesの管理

```bash
# dotfilesのシンボリックリンクを作成
./install up

# dotfilesのシンボリックリンクを削除
./install down
```

## アーキテクチャ

このリポジトリは個人用dotfiles管理システムで、Nixとmigrationシステムを組み合わせた構成：

### Nixによるシステム管理
- `flake.nix` - Nixフレークの設定、nix-darwinとhome-managerの統合
- `nix/darwin.nix` - macOS固有の設定（Homebrew、システム設定、セキュリティ設定）
- `nix/home.nix` - ユーザー環境の設定
- アーキテクチャはaarch64-darwin（Apple Silicon Mac）向け

### Migration管理システム
- `install` - migration実行スクリプト
- `migrations/` - 設定ファイルのシンボリックリンク作成スクリプト
- `migrations/__setup__` - migration共通関数の定義
- 主要設定ファイルを`~/.config/`や`~/`にシンボリックリンクで配置

### 設定対象
Neovim、Git、シェル（Bash/Zsh/Fish）、ターミナル（Kitty/Alacritty/WezTerm）、エディタ（Vim/Emacs/Helix）、ウィンドウマネージャー（Yabai/Sketchybar）など100種類以上のツール設定を管理