# WezTerm Spotify Plugin

WezTerm のステータスバーに Spotify の再生情報を表示し、キーボードショートカットで Spotify を制御できるプラグインです。

## 機能

### ステータスバー表示

- 現在再生中の楽曲名とアーティスト名を表示
- 再生/一時停止状態をアイコンで表示
- Spotify 公式の緑色（再生中）とグレー（一時停止中）で色分け

### キーボードショートカット

以下のキーボードショートカットで Spotify を制御できます：

- `Cmd+Shift+S`: 再生/一時停止の切り替え
- `Cmd+Shift+N`: 次の曲
- `Cmd+Shift+P`: 前の曲
- `Cmd+Shift+I`: 現在の楽曲情報を通知で表示
- `Cmd+Shift+=`: 音量を上げる
- `Cmd+Shift+-`: 音量を下げる

## 必要条件

- macOS（AppleScript を使用して Spotify を制御）
- Spotify アプリケーション
- WezTerm

## ファイル構成

- `spotify.lua`: Spotify 情報取得とキャッシュ機能
- `spotify-controls.lua`: Spotify コントロール機能
- `status.lua`: ステータスバー統合（更新済み）
- `keybinds.lua`: キーバインド設定（更新済み）
- `colors.lua`: Spotify 用の色定義（更新済み）

## 設定の詳細

### キャッシュ機能

- Spotify 情報は 5 秒間キャッシュされ、AppleScript の実行頻度を抑制
- 楽曲名が長い場合は自動的に省略表示

### エラーハンドリング

- Spotify が起動していない場合は何も表示しない
- AppleScript 実行エラーは自動的に処理される

## カスタマイズ

### 表示テキストの長さ制限

`spotify.lua`の`format_track_display`関数で調整可能：

```lua
local function format_track_display(track, artist, max_length)
  max_length = max_length or 30 -- この値を変更
  -- ...
end
```

### キャッシュ時間

`spotify.lua`の`CACHE_DURATION`変数で調整可能：

```lua
local CACHE_DURATION = 5000 -- ミリ秒単位（5秒）
```

### 色の変更

`colors.lua`で Spotify 用の色を変更可能：

```lua
SPOTIFY_GREEN = { Color = "#1DB954" }, -- 再生中の色
SPOTIFY_GRAY = { Color = "#B3B3B3" },  -- 一時停止中の色
```

## トラブルシューティング

1. **Spotify の情報が表示されない**

   - Spotify アプリが起動していることを確認
   - macOS のプライバシー設定で WezTerm に AppleScript の実行許可が与えられていることを確認

2. **キーボードショートカットが動作しない**

   - 他のアプリケーションと競合していないか確認
   - WezTerm がアクティブな状態で実行していることを確認

3. **パフォーマンスの問題**
   - キャッシュ時間を長くする（`CACHE_DURATION`を増加）
   - 表示テキストの長さ制限を短くする

## 更新履歴

- 初回リリース: Spotify 情報表示とキーボードコントロール機能
