# 通知一覧をブラウザで開いてから、既読になった件数を取り込み直す
open "https://github.com/notifications"

sleep 1
sketchybar --trigger github_update
