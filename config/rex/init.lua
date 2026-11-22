-- Rex (Superlogical) の設定ファイル。
--
-- Rex がファイルから読むのはキーバインド (rex.bind / rex.unbind)、モード
-- (rex.mode)、独自アクション (rex.action) とイベントハンドラ (rex.on) だけ。
-- フォント・テーマ・サイドバーなどアプリの設定は macOS の defaults
-- (com.superlogical.rex) に保存され、このファイルでは扱わない。
--
-- 確認とリロード (rex CLI は /Applications/Rex.app/Contents/Helpers/ 配下):
--   rex config check ~/dotfiles/config/rex/init.lua
--   rex config reload
--   rex keymap
--
-- 書き方 (0.1.0-preview.21 時点。公開ドキュメントが無いので `rex config check`
-- で確かめたもの):
--   rex.bind(KEY, ACTION[, ARGS])    ACTION は `rex -C <app> actions` の名前
--   rex.mode(NAME[, { exclusive = BOOL }])
--   KEY は "cmd+shift+r"、シーケンスは "ctrl+b>c"、モード内は "resize/h"

-- 既定のキー (メニューバーで確認できるもの) はそのまま使う。
--   分割: cmd+d / cmd+shift+d    フォーカス: cmd+opt+矢印, cmd+[ / cmd+]
--   移動: cmd+opt+shift+矢印     ズーム: cmd+shift+enter
--   セッション切替: cmd+k        コマンドパレット: cmd+shift+p
-- ペインのリサイズ・バランス・コピーモードには既定のキーが無いので、ここで足す。
--
-- hjkl を修飾キー付きで直接割り当てないのは、AeroSpace が alt+shift / ctrl+cmd /
-- alt+ctrl + hjkl を、macOS が cmd+opt+h (Hide Others) を先に持っていくため。
-- 代わりにモードに入ってから素の hjkl を押す。

-- リサイズモード: cmd+shift+r で入り、hjkl / 矢印で境界線を動かす。
-- exclusive にして、モード中に押し間違えたキーが端末へ流れないようにする。
-- pane.resize は repeats なので押しっぱなしで動き続ける。
rex.mode("resize", { exclusive = true })
rex.bind("cmd+shift+r", "client.mode.enter", { name = "resize" })

local directions = {
  h = "left",
  j = "down",
  k = "up",
  l = "right",
}
for key, direction in pairs(directions) do
  rex.bind("resize/" .. key, "pane.resize", { direction = direction })
  rex.bind("resize/" .. direction, "pane.resize", { direction = direction })
  -- 大文字 (shift) で細かく動かす。既定の幅は 5%。
  rex.bind("resize/shift+" .. key, "pane.resize", { direction = direction, amount = 1 })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/escape", "client.mode.exit")
rex.bind("resize/enter", "client.mode.exit")
rex.bind("resize/q", "client.mode.exit")

-- コピーモード: スクロールバックを vim 風に辿って選択する。
rex.bind("cmd+shift+c", "pane.copy_mode.enter")
