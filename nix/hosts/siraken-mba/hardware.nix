# Drivers and quirks of the MacBook Air (13-inch, Early 2014, MacBookAir6,2)
# that nixos-hardware's `apple-macbook-air-6` leaves out. That module already
# brings facetimehd (when unfree is allowed), mbpfan, fstrim, the i915 initrd
# module, the `bcma` blacklist and `acpi_osi=`.
{
  config,
  lib,
  pkgs,
  ...
}:
{
  boot = {
    # wl and facetimehd are out-of-tree modules that tend to break on new
    # kernels; stay on nixpkgs' default (LTS) kernel.
    kernelPackages = pkgs.linuxPackages;

    # Wi-Fi: Broadcom BCM4360 [14e4:43a0] has no in-tree driver, only the
    # proprietary wl.
    kernelModules = [ "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
    blacklistedKernelModules = [
      "b43"
      "ssb"
      "brcmsmac"
      "brcmfmac"
    ];

    # F1-F12 are function keys; media keys need Fn (what Omarchy set).
    extraModprobeConfig = ''
      options hid_apple fnmode=2
    '';
  };

  # WORKAROUND: broadcom-sta is marked insecure (CVE-2019-9501, CVE-2019-9502)
  # and refuses to evaluate without this. Without it there is no Wi-Fi on
  # this machine. There is no fixed version upstream; drop this once the
  # internal card is no longer used (e.g. a USB Wi-Fi adapter instead).
  nixpkgs.config.allowInsecurePredicate = pkg: lib.getName pkg == "broadcom-sta";

  hardware = {
    cpu.intel.updateMicrocode = true;
    # Bluetooth (BCM20702, btusb) firmware and the rest of linux-firmware.
    enableRedistributableFirmware = true;

    facetimehd = {
      enable = true;
      # Sensor calibration (1871_01XX.dat), extracted from Apple's Boot Camp
      # driver: without it the camera works but its colors are off.
      withCalibration = true;
    };

    # Haswell (HD 5000) is only supported by the i965 VA-API driver;
    # nixos-hardware's generic Intel module would also add intel-media-driver
    # and compute-runtime, which need Broadwell or later.
    intelgpu = {
      vaapiDriver = "intel-vaapi-driver";
      enableHybridCodec = true;
    };

    bluetooth.enable = true;
  };

  services = {
    # Fans on a quieter curve than NixOS's default (`aggressive`: ramping from
    # 58 °C, polled every second). Short bursts such as opening a page take
    # this Haswell CPU past 60 °C at once, so that curve spun the fans up for
    # every one of them. This one stays at the minimum below 70 °C and reaches
    # full speed at 92 °C, closer to macOS (TjMax is 100 °C, and thermald and
    # the CPU's own throttling stay in place). The case runs warmer.
    mbpfan.settings.general = {
      low_temp = 70;
      high_temp = 80;
      max_temp = 92;
      polling_interval = 3;
    };
    power-profiles-daemon.enable = true;
    thermald.enable = true;
    upower.enable = true;
  };

  # The internal trackpad (bcm5974, 05ac:0291) took light brushes as taps.
  # With `libinput measure touch-size`, brushes peaked at a touch major of
  # 122-310 and deliberate taps at 352-512. libinput's Apple default is
  # 150:130; 300:280 kept the brushes out but made the pointer sluggish, so
  # this is halfway. Read when the compositor starts: log in again to apply.
  environment.etc."libinput/local-overrides.quirks".text = ''
    [siraken-mba internal trackpad]
    MatchUdevType=touchpad
    MatchBus=usb
    MatchVendor=0x05AC
    MatchProduct=0x0291
    AttrTouchSizeRange=225:205
  '';

  environment.systemPackages = [
    # Display and keyboard backlight (smc::kbd_backlight).
    pkgs.brightnessctl
  ];
}
