# Cycles / Health は popup を開くときだけ取得する（定期ポーリングの battery.sh で
# 毎回 ioreg を走らせないため）。
# BatteryData の巨大な blob 内にも同名キーがあるが、そちらは "Key"=value と
# 空白が無いため ' = ' 区切りのパターンには引っかからない。
{
  IFS= read -r CYCLES
  IFS= read -r NOMINAL
  IFS= read -r DESIGN
} < <(
  ioreg -rn AppleSmartBattery -w0 | awk -F' = ' '
    /"CycleCount" = / && cycles == "" { cycles = $2 }
    /"NominalChargeCapacity" = / && nominal == "" { nominal = $2 }
    /"DesignCapacity" = / && design == "" { design = $2 }
    END { print cycles; print nominal; print design }
  '
)

if [[ $NOMINAL =~ ^[0-9]+$ && $DESIGN =~ ^[0-9]+$ ]] && [ "$DESIGN" -gt 0 ]; then
  HEALTH="$((NOMINAL * 100 / DESIGN))%"
else
  HEALTH="Unknown"
fi

sketchybar \
  --set battery.popup.cycles label="Cycles: ${CYCLES:-Unknown}" \
  --set battery.popup.health label="Health: $HEALTH" \
  --set "$NAME" popup.drawing=toggle
