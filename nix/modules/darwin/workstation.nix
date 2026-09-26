{
  pkgs,
  ...
}:
let
  # HID key codes for keyboard remapping (used with hidutil)
  # Reference: https://developer.apple.com/library/archive/technotes/tn2450/_index.html
  hidKeys = {
    rightOption = "0x7000000E6";
    fn = "0xFF00000003";
  };

  mkKeyMapping =
    let
      hexToInt = s: pkgs.lib.trivial.fromHexString s;
    in
    src: dst: {
      HIDKeyboardModifierMappingSrc = hexToInt src;
      HIDKeyboardModifierMappingDst = hexToInt dst;
    };
in
{
  imports = [
    ../../services/darwin/aerospace.nix
    ../../services/darwin/jankyborders.nix
    ../../services/darwin/sketchybar
  ];

  system = {
    keyboard = {
      enableKeyMapping = true;
      userKeyMapping = [
        (mkKeyMapping hidKeys.rightOption hidKeys.fn)
      ];
    };
    defaults = {
      finder = {
        AppleShowAllExtensions = false;
        AppleShowAllFiles = false;
        ShowPathbar = true;
        ShowStatusBar = true;
        NewWindowTarget = "Home";
      };
      NSGlobalDomain = {
        NSWindowShouldDragOnGesture = true;
        "com.apple.mouse.tapBehavior" = 1;
        InitialKeyRepeat = 15;
        KeyRepeat = 2;
        ApplePressAndHoldEnabled = false;
        AppleInterfaceStyle = "Dark";
        _HIHideMenuBar = true;
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        "com.apple.trackpad.forceClick" = true;
      };
      trackpad = {
        Clicking = true;
        TrackpadRightClick = true;
        TrackpadThreeFingerDrag = false;
        TrackpadPinch = true;
        TrackpadRotate = true;
        TrackpadMomentumScroll = true;
        FirstClickThreshold = 1;
        SecondClickThreshold = 1;
      };
      menuExtraClock = {
        ShowAMPM = true;
        ShowDate = 0;
        ShowDayOfWeek = true;
      };
      WindowManager = {
        GloballyEnabled = false;
        EnableStandardClickToShowDesktop = false;
        EnableTiledWindowMargins = false;
      };
      screensaver = {
        askForPassword = true;
        askForPasswordDelay = 0;
      };
      CustomUserPreferences = {
        "com.apple.desktopservices" = {
          DSDontWriteNetworkStores = true;
        };
        "com.apple.inputmethod.Kotoeri" = {
          JIMPrefAutocorrectionKey = false;
          JIMPrefWindowsModeKey = true;
        };
        "com.apple.screensaver" = {
          idleTime = 180;
        };
        "com.microsoft.VSCode" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.jetbrains.PhpStorm" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.jetbrains.WebStorm" = {
          ApplePressAndHoldEnabled = false;
        };
        "com.jetbrains.rubymine" = {
          ApplePressAndHoldEnabled = false;
        };
      };
    };
  };

  power.sleep = {
    display = 5;
    harddisk = 10;
  };

  fonts.packages = with pkgs; [
    nerd-fonts.hack
    source-code-pro
    monocraft
    udev-gothic
    sketchybar-app-font
  ];
}
