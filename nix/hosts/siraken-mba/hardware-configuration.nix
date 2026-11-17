# Disks of the MacBook Air (MacBookAir6,2): one SSD with a 2 GiB ESP and a
# LUKS2 container holding a single btrfs filesystem.
#
# Written by hand from the Omarchy install it replaced, not by
# nixos-generate-config. NixOS was installed next to Omarchy into its own root
# subvolume (`@nixos`), taking over `@home`, `@nix` and `@log`; Omarchy's `@`,
# `@pkg` and `@factory` were deleted afterwards (#244). The root keeps the name
# `@nixos`.
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
    # Its own subvolume, so the root can be snapshotted without the swapfile.
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

  # Hibernation resumes from the swapfile (8 GiB, made with `btrfs filesystem
  # mkswapfile`). Recreating the file changes the offset: read it again with
  # `btrfs inspect-internal map-swapfile -r /swap/swapfile`.
  boot.resumeDevice = "/dev/mapper/root";
  boot.kernelParams = [ "resume_offset=9708800" ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
