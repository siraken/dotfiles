{ pkgs, lib, ... }:
let
  # Colors (Tokyo Night theme)
  colors = {
    transparent = "0x00000000";
    background = "0xff1a1b26";
    surface = "0xff292e42";
    border = "0xff2f3549";
    shadow = "0x40000000";
    white = "0xffffffff";
    muted = "0xff565f89";
    purple = "0xff9d7cd8";
    # ワークスペースのフォーカス表示。塗りつぶしなので、細い文字として置くのとは
    # 濃さの見え方が変わる。palette 外の色を作らず、TokyoNight 自身が lualine 等で
    # 使っている「アクセント色を塗って文字を地の色にする」形にしている。
    focusFill = "0xff7aa2f7"; # palette の blue
    pink = "0xfff7768e";
    orange = "0xffff9e64";
    green = "0xff9ece6a";
    spotifyGreen = "0xff1ed760";
    appleMusicPink = "0xffff4e6b";
  };

  # Binaries
  aerospace = "${pkgs.aerospace}/bin/aerospace";

  # ワークスペースのアプリアイコン用フォント（`:app_name:` のリガチャで描画される）
  appFont = pkgs.sketchybar-app-font;

  # AeroSpace の persistent-workspaces と共有するワークスペース一覧。
  # 実行時に aerospace へ問い合わせるとウィンドウがあるものしか拾えないため、
  # アイテムの集合はこちらから決める。
  workspaces = import ../workspaces.nix;

  # 全プラグインの先頭に差し込む共通定義。
  # 色は Nix 側の 1 箇所で管理し、PATH も明示して起動環境に依存しないようにする。
  # (GNU 版で挙動が変わる grep / date などを拾わないよう、システムのパスのみを足している)
  prelude = ''
    export PATH="${pkgs.sketchybar}/bin:${pkgs.aerospace}/bin:${pkgs.switchaudio-osx}/bin:/usr/bin:/bin:/usr/sbin:/sbin"

    COLOR_TRANSPARENT=${colors.transparent}
    COLOR_BG=${colors.background}
    COLOR_SURFACE=${colors.surface}
    COLOR_BORDER=${colors.border}
    COLOR_WHITE=${colors.white}
    COLOR_MUTED=${colors.muted}
    COLOR_PURPLE=${colors.purple}
    COLOR_FOCUS_FILL=${colors.focusFill}
    COLOR_PINK=${colors.pink}
    COLOR_ORANGE=${colors.orange}
    COLOR_GREEN=${colors.green}
    COLOR_SPOTIFY=${colors.spotifyGreen}
    COLOR_APPLE_MUSIC=${colors.appleMusicPink}
  '';

  mkPlugin =
    {
      name,
      extraPrelude ? "",
    }:
    pkgs.writeShellScript name (prelude + extraPrelude + builtins.readFile (./plugins + "/${name}"));

  spacesPlugin = mkPlugin {
    name = "spaces.sh";
    extraPrelude = ''
      source ${appFont}/bin/icon_map.sh
    '';
  };
  clockPlugin = mkPlugin { name = "clock.sh"; };
  clockClickPlugin = mkPlugin { name = "clock_click.sh"; };
  batteryPlugin = mkPlugin { name = "battery.sh"; };
  batteryClickPlugin = mkPlugin { name = "battery_click.sh"; };
  volumePlugin = mkPlugin { name = "volume.sh"; };
  volumeClickPlugin = mkPlugin { name = "volume_click.sh"; };
  volumeSliderPlugin = mkPlugin { name = "volume_slider.sh"; };
  volumeDevicePlugin = mkPlugin { name = "volume_device.sh"; };
  frontAppPlugin = mkPlugin { name = "front_app.sh"; };
  mediaPlugin = mkPlugin { name = "media.sh"; };
  mediaClickPlugin = mkPlugin { name = "media_click.sh"; };
  mediaControlPlugin = mkPlugin { name = "media_control.sh"; };
  inputSourcePlugin = mkPlugin { name = "input_source.sh"; };
in
{
  services.sketchybar = {
    enable = true;
    config = ''
      # バー自体は透明で、島だけが浮いて見える構成。
      # 島は 30px の背景が 38px のバーの中央に置かれるので、バー内で上下に 4px ずつ
      # 余白がある。y_offset=2 を足すと画面上端から島まで 6px、島の下端 (36) から
      # ウィンドウ上端 (42, AeroSpace の outer.top) までも 6px となり上下が揃う。
      sketchybar --bar \
        position=top \
        height=38 \
        y_offset=2 \
        blur_radius=0 \
        font_smoothing=on \
        color=${colors.transparent}

      default=(
        icon.font="Hack Nerd Font:regular:17.0"
        label.font="Hack Nerd Font:regular:12.0"
        icon.padding_left=8
        icon.padding_right=0
        label.padding_left=8
        label.padding_right=8
        background.height=30
        background.corner_radius=6
        padding_left=3
        padding_right=3
      )
      sketchybar --default "''${default[@]}"

      # 背景を持つ「島」に共通で載せる縁取りと影
      island=(
        background.border_width=1
        background.border_color=${colors.border}
        background.shadow.drawing=on
        background.shadow.color=${colors.shadow}
        background.shadow.distance=3
      )

      # popup の中に入るアイテムの共通設定
      popup_item=(
        icon.font="Hack Nerd Font:regular:13.0"
        icon.padding_left=12
        icon.padding_right=6
        label.font="Hack Nerd Font:regular:12.0"
        label.color=${colors.white}
        label.padding_left=0
        label.padding_right=12
        background.drawing=off
        padding_left=0
        padding_right=0
      )

      # popup 本体の共通設定
      popup_style=(
        popup.background.color=${colors.background}
        popup.background.corner_radius=8
        popup.background.border_width=1
        popup.background.border_color=${colors.border}
        popup.background.shadow.drawing=on
        popup.background.shadow.color=${colors.shadow}
        popup.align=right
        popup.y_offset=4
        popup.height=22
      )

      ##### Left Items #####

      # AeroSpace workspaces
      sketchybar --add event aerospace_workspace_change

      # label には sketchybar-app-font のアプリアイコンが入る。このフォントの
      # グリフは icon 側の Hack より 1pt ほど高い位置に乗り、画素で測ると数字の
      # 中心より 1.5px (retina) 上にずれるので y_offset で下げている。
      #
      # ハイライトの周囲の余白は上下が (30 - 24) / 2 - 1(枠線) = 2px。左右も揃える
      # には padding からブラケットの枠線 1px を引いた値が 2 になればよいので 3 にする。
      SPACE_SIDS=()
      SPACE_IDS=()
      for sid in ${lib.concatStringsSep " " workspaces}; do
        sketchybar --add item space.$sid left \
          --set space.$sid \
            background.color=${colors.transparent} \
            background.corner_radius=5 \
            background.height=24 \
            background.drawing=on \
            icon="$sid" \
            icon.font="Hack Nerd Font:bold:12.0" \
            icon.color=${colors.muted} \
            icon.padding_left=9 \
            icon.padding_right=9 \
            label.font="sketchybar-app-font:Regular:14.0" \
            label.color=${colors.muted} \
            label.drawing=off \
            label.y_offset=-1 \
            padding_left=3 \
            padding_right=3 \
            click_script="${aerospace} workspace $sid"
        SPACE_SIDS+=("space.$sid")
        SPACE_IDS+=("$sid")
      done

      sketchybar --add bracket spaces "''${SPACE_SIDS[@]}" \
        --set spaces \
          "''${island[@]}" \
          background.color=${colors.background} \
          background.corner_radius=6 \
          background.height=30 \
          background.drawing=on

      # ワークスペース表示は 1 本のドライバでまとめて更新する（自身は描画しない）。
      # AeroSpace 側の on-focus-changed / on-focused-monitor-changed からも
      # aerospace_workspace_change が飛ぶため、定期ポーリングは持たせていない。
      sketchybar --add item spaces_watcher left \
        --set spaces_watcher \
          drawing=off \
          updates=on \
          script="${spacesPlugin} ''${SPACE_IDS[*]}" \
        --subscribe spaces_watcher \
          aerospace_workspace_change \
          front_app_switched \
          space_windows_change \
          display_change

      # Front app
      sketchybar --add item front_app left \
        --set front_app "''${island[@]}" script="${frontAppPlugin}" \
        --subscribe front_app front_app_switched

      ##### Right Items #####
      # Note: right items are rendered right-to-left (first added = rightmost)

      sketchybar --add item clock right \
        --set clock \
          "''${island[@]}" \
          "''${popup_style[@]}" \
          update_freq=10 \
          script="${clockPlugin}" \
          click_script="${clockClickPlugin}" \
        --subscribe clock mouse.exited.global

      # カレンダー用の行（cal は常に 8 行を出力する）
      for i in 0 1 2 3 4 5 6 7; do
        sketchybar --add item clock.popup.$i popup.clock \
          --set clock.popup.$i \
            "''${popup_item[@]}" \
            icon.drawing=off \
            label.padding_left=12 \
            label.align=left
      done
      sketchybar --set clock.popup.0 \
        label.color=${colors.orange} \
        label.font="Hack Nerd Font:bold:12.0"
      sketchybar --set clock.popup.1 label.color=${colors.muted}

      # 音量: バー上のスクロールで上下、クリックで popup（スライダーと出力デバイス）
      sketchybar --add event volume_update
      sketchybar --add item volume right \
        --set volume \
          "''${island[@]}" \
          "''${popup_style[@]}" \
          script="${volumePlugin}" \
          click_script="${volumeClickPlugin} ${volumeDevicePlugin}" \
        --subscribe volume volume_change volume_update mouse.scrolled mouse.exited.global

      sketchybar --add slider volume.popup.slider popup.volume 130 \
        --set volume.popup.slider \
          script="${volumeSliderPlugin}" \
          icon.drawing=off \
          label.drawing=off \
          background.drawing=off \
          padding_left=12 \
          padding_right=12 \
          slider.background.height=6 \
          slider.background.corner_radius=3 \
          slider.background.color=${colors.surface} \
          slider.highlight_color=${colors.pink} \
          slider.knob="●" \
          slider.knob.font="Hack Nerd Font:Bold:14.0" \
          slider.knob.color=${colors.white} \
        --subscribe volume.popup.slider mouse.clicked

      # 出力デバイスの選択肢。数は接続状況で変わるのでスロットを固定数用意しておく。
      for i in ${lib.concatStringsSep " " (map toString (lib.range 0 15))}; do
        sketchybar --add item volume.popup.device.$i popup.volume \
          --set volume.popup.device.$i "''${popup_item[@]}" drawing=off
      done

      sketchybar --add item battery right \
        --set battery \
          "''${island[@]}" \
          "''${popup_style[@]}" \
          update_freq=120 \
          script="${batteryPlugin}" \
          click_script="${batteryClickPlugin}" \
        --subscribe battery system_woke power_source_change mouse.exited.global

      sketchybar --add item battery.popup.status popup.battery \
        --set battery.popup.status "''${popup_item[@]}" icon=󰁹 icon.color=${colors.purple}
      sketchybar --add item battery.popup.time popup.battery \
        --set battery.popup.time "''${popup_item[@]}" icon=󰥔 icon.color=${colors.orange}
      sketchybar --add item battery.popup.cycles popup.battery \
        --set battery.popup.cycles "''${popup_item[@]}" icon=󰑐 icon.color=${colors.green}
      sketchybar --add item battery.popup.health popup.battery \
        --set battery.popup.health "''${popup_item[@]}" icon=󰋑 icon.color=${colors.pink}

      # 入力ソース。専用イベントは無いが、システムが配信する通知を購読できるので
      # ポーリングせずに済む。
      sketchybar --add event input_source_change AppleSelectedInputSourcesChangedNotification
      sketchybar --add item input_source right \
        --set input_source "''${island[@]}" script="${inputSourcePlugin}" \
        --subscribe input_source input_source_change

      # Spotify と Apple Music を 1 つのアイテムに統合し、操作時は即時更新する。
      # 左クリックで再生/一時停止、右クリックで曲送りの popup を開く。
      #
      # 幅は曲名に合わせて伸縮させる（label.width は既定の dynamic）。固定にすると
      # 曲名が短いときに島の右側が間延びするため、代わりに上限をプラグイン側に持たせ、
      # 超えた分を「…」に置き換えている。
      #
      # 上限が要るのは、曲名の長さでアイテムが左へ伸びると内蔵ディスプレイの
      # ノッチ (x=663..848 と実測) に潜り込んでしまうため。ラベルの上限幅 204px に
      # 左右の padding 8px ずつを足した 220px が最大で、このとき右端 1142 に対して
      # 左端は 896 までしか伸びず、ノッチまで 48px 残る。
      sketchybar --add event media_update
      sketchybar --add item media right \
        --set media \
          "''${island[@]}" \
          "''${popup_style[@]}" \
          popup.horizontal=on \
          update_freq=3 \
          script="${mediaPlugin} 204" \
          click_script="${mediaClickPlugin} ${mediaControlPlugin}" \
        --subscribe media media_update mouse.exited.global

      sketchybar --add item media.popup.prev popup.media \
        --set media.popup.prev \
          "''${popup_item[@]}" \
          icon=󰒮 \
          icon.padding_left=14 \
          icon.padding_right=14 \
          label.drawing=off \
          click_script="${mediaControlPlugin} previous"
      sketchybar --add item media.popup.play popup.media \
        --set media.popup.play \
          "''${popup_item[@]}" \
          icon=󰐊 \
          icon.padding_left=14 \
          icon.padding_right=14 \
          label.drawing=off \
          click_script="${mediaControlPlugin} toggle"
      sketchybar --add item media.popup.next popup.media \
        --set media.popup.next \
          "''${popup_item[@]}" \
          icon=󰒭 \
          icon.padding_left=14 \
          icon.padding_right=14 \
          label.drawing=off \
          click_script="${mediaControlPlugin} next"

      sketchybar --update
      sketchybar --trigger aerospace_workspace_change
    '';
  };
}
