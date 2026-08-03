# バーの外にカーソルが出たら popup を閉じる
if [ "$SENDER" = "mouse.exited.global" ]; then
  sketchybar --set "$NAME" popup.drawing=off
  exit 0
fi

BATT="$(pmset -g batt)"
PERCENTAGE="$(printf '%s\n' "$BATT" | grep -Eo '[0-9]+%' | head -n1 | tr -d '%')"

if [ -z "$PERCENTAGE" ]; then
  exit 0
fi

# pmset の状態文字列から充電状態を判定する
# ("not charging" を "charging" より先に判定する必要がある)
case "$BATT" in
*"; charged"*) STATUS=charged ;;
*"; not charging"*) STATUS=plugged ;;
*"; charging"*) STATUS=charging ;;
*) STATUS=discharging ;;
esac

if [ "$STATUS" = charging ]; then
  ICON="󰂄"
else
  case "$PERCENTAGE" in
  9[0-9] | 100) ICON="" ;;
  [6-8][0-9]) ICON="" ;;
  [3-5][0-9]) ICON="" ;;
  [1-2][0-9]) ICON="" ;;
  *) ICON="" ;;
  esac
fi

# 残量と充電状態で色を変える（従来は常に紫だったため 10% と 90% が見分けられなかった）
if [ "$STATUS" = charging ] || [ "$STATUS" = charged ]; then
  COLOR="$COLOR_GREEN"
elif [ "$PERCENTAGE" -lt 20 ]; then
  COLOR="$COLOR_PINK"
elif [ "$PERCENTAGE" -lt 40 ]; then
  COLOR="$COLOR_ORANGE"
else
  COLOR="$COLOR_PURPLE"
fi

##### popup の中身 #####

case "$STATUS" in
charging) STATUS_TEXT="Charging" ;;
charged) STATUS_TEXT="Charged" ;;
plugged) STATUS_TEXT="AC (not charging)" ;;
*) STATUS_TEXT="On battery" ;;
esac

REMAINING="$(printf '%s\n' "$BATT" | grep -Eo '[0-9]+:[0-9]{2}' | head -n1)"
if [ -n "$REMAINING" ] && [ "$REMAINING" != "0:00" ]; then
  if [ "$STATUS" = charging ]; then
    TIME_TEXT="$REMAINING until full"
  else
    TIME_TEXT="$REMAINING remaining"
  fi
else
  TIME_TEXT="No estimate"
fi

# ioreg の AppleSmartBattery からサイクル数と最大容量を取る。
# BatteryData の巨大な blob 内にも同名キーがあるが、そちらは "Key"=value と
# 空白が無いため ' = ' 区切りのパターンには引っかからない。
IOREG="$(ioreg -rn AppleSmartBattery -w0)"
CYCLES="$(printf '%s\n' "$IOREG" | awk -F' = ' '/"CycleCount" = /{ print $2; exit }')"
NOMINAL="$(printf '%s\n' "$IOREG" | awk -F' = ' '/"NominalChargeCapacity" = /{ print $2; exit }')"
DESIGN="$(printf '%s\n' "$IOREG" | awk -F' = ' '/"DesignCapacity" = /{ print $2; exit }')"

if [[ $NOMINAL =~ ^[0-9]+$ && $DESIGN =~ ^[0-9]+$ ]] && [ "$DESIGN" -gt 0 ]; then
  HEALTH="$((NOMINAL * 100 / DESIGN))%"
else
  HEALTH="Unknown"
fi

sketchybar --set "$NAME" \
  icon="$ICON" \
  icon.color="$COLOR" \
  label="$PERCENTAGE%" \
  label.color="$COLOR" \
  background.color="$COLOR_BG" \
  background.drawing=on \
  --set battery.popup.status label="$STATUS_TEXT" \
  --set battery.popup.time label="$TIME_TEXT" \
  --set battery.popup.cycles label="Cycles: ${CYCLES:-Unknown}" \
  --set battery.popup.health label="Health: $HEALTH"
