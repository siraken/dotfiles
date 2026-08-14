# WezTerm Spotify Plugin

キーボードショートカットで Spotify を制御できる WezTerm 用のプラグインです。

## 機能

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
- `keybinds.lua`: キーバインド設定（更新済み）

## 設定の詳細

### キャッシュ機能

- Spotify 情報は 5 秒間キャッシュされ、AppleScript の実行頻度を抑制

### エラーハンドリング

- Spotify が起動していない場合は通知でその旨を表示
- AppleScript 実行エラーは自動的に処理される

## カスタマイズ

### キャッシュ時間

`spotify.lua`の`CACHE_DURATION`変数で調整可能：

```lua
local CACHE_DURATION = 5000 -- ミリ秒単位（5秒）
```

## トラブルシューティング

1. **Spotify の情報が取得できない**

   - Spotify アプリが起動していることを確認
   - macOS のプライバシー設定で WezTerm に AppleScript の実行許可が与えられていることを確認

1. **キーボードショートカットが動作しない**

   - 他のアプリケーションと競合していないか確認
   - WezTerm がアクティブな状態で実行していることを確認

1. **パフォーマンスの問題**

   - キャッシュ時間を長くする（`CACHE_DURATION`を増加）

## 更新履歴

- 初回リリース: Spotify 情報表示とキーボードコントロール機能
- ステータスバー表示を削除: タブ管理を herdr に任せ、`hide_tab_bar_if_only_one_tab` でタブバーごと隠すようにしたため。キーボードコントロールは維持
