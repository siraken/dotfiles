# Disks of the MacBook Air (MacBookAir6,2): one SSD with a 2 GiB ESP and a
# LUKS2 container holding a single btrfs filesystem.
#
# Written by hand from the running Omarchy install, not by
# nixos-generate-config. NixOS gets its own root subvolume (`@nixos`) next to
# Omarchy's `@` and shares `@home`, `@nix` and `@log` with it, so Omarchy stays
# bootable until the migration is done. Once it is, Omarchy's `@` and `@pkg`
# can be deleted and `@nixos` renamed to `@` (update `subvol=` below in the
# same step).
{ lib, ... }:
let
  btrfsDevice = "/dev/disk/by-uuid/b648a331-26bd-4c70-bfcc-22e98c322014";
  btrfsOptions = [
    "compress=zstd:3"
    "noatime"
  ];
  subvolume = name: {
    device = btrfsDevice;
    fsType = "btrfs";
    options = [ "subvol=${name}" ] ++ btrfsOptions;
  };
in
{
  boot.initrd = {
    # The internal keyboard is on USB (not SPI on this model), so the LUKS
    # passphrase needs usbhid and hid_apple in the initrd.
    availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usbhid"
      "hid_apple"
      "usb_storage"
      "uas"
      "sd_mod"
    ];
    luks.devices.root = {
      device = "/dev/disk/by-uuid/1d876d71-a26b-447e-8f0b-7888f6896691";
      allowDiscards = true;
    };
  };

  fileSystems = {
    "/" = subvolume "@nixos";
    "/home" = subvolume "@home";
    "/nix" = subvolume "@nix";
    "/var/log" = subvolume "@log";
    # Created at install time; Omarchy's swapfile lives in its own `@`, which
    # goes away after the migration.
    "/swap" = subvolume "@swap";
    "/boot" = {
      device = "/dev/disk/by-uuid/69D3-3185";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };

  swapDevices = [
    {
      device = "/swap/swapfile";
      # Below zram, which is the swap in daily use; the file is for hibernation.
      priority = 0;
    }
  ];

  # Hibernation resumes from the swapfile. Its offset is only known once the
  # file exists: `btrfs inspect-internal map-swapfile -r /swap/swapfile`.
  boot.resumeDevice = "/dev/mapper/root";
  # boot.kernelParams = [ "resume_offset=<offset>" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
