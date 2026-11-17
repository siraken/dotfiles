# Fonts, with Japanese first (#289). Left to fontconfig's defaults, sans,
# serif and monospace were DejaVu, and Japanese fell back to Noto Sans CJK KR,
# drawing kanji in the Korean forms.
{ lib, pkgs, ... }:
{
  fonts = {
    # The graphical-desktop defaults (DejaVu, FreeFont, Liberation, Unifont,
    # …) are replaced by the list below.
    enableDefaultPackages = false;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
      # Wide coverage for symbols the others lack.
      dejavu_fonts
    ];

    fontconfig = {
      # The JP variants right after the Latin family, so CJK text that names
      # no font gets the Japanese forms.
      defaultFonts = {
        sansSerif = [
          "Noto Sans"
          "Noto Sans CJK JP"
        ];
        serif = [
          "Noto Serif"
          "Noto Serif CJK JP"
        ];
        monospace = [
          "Hack Nerd Font Mono"
          "Noto Sans Mono CJK JP"
        ];
        emoji = [ "Noto Color Emoji" ];
      };
      # NixOS has no option for system-ui, the generic family of UI fonts;
      # fontconfig's own order for it puts Noto Sans CJK KR before JP. GTK's
      # UI fonts, Adwaita Sans and Cantarell (neither installed), are mapped to
      # system-ui by a later conf.d file than this one (51-local.conf), so
      # they get the same order here directly.
      localConf =
        let
          japaneseFirst = family: ''
            <alias binding="same">
              <family>${family}</family>
              <prefer>
                <family>Noto Sans</family>
                <family>Noto Sans CJK JP</family>
              </prefer>
            </alias>
          '';
        in
        ''
          <?xml version="1.0"?>
          <!DOCTYPE fontconfig SYSTEM "urn:fontconfig:fonts.dtd">
          <fontconfig>
          ${lib.concatMapStrings japaneseFirst [
            "system-ui"
            "Adwaita Sans"
            "Cantarell"
          ]}
          </fontconfig>
        '';
      # The 1440x900 panel is not HiDPI: keep the glyphs crisp.
      antialias = true;
      hinting = {
        enable = true;
        style = "slight";
      };
      subpixel = {
        rgba = "rgb";
        lcdfilter = "default";
      };
    };
  };
}
