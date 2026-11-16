# `nixos-rebuild build-vm --flake .#siraken-mba`: the desktop in QEMU, to try
# it before installing. Only affects the VM; the real system is unchanged.
#
#   nixos-rebuild build-vm --flake .#siraken-mba
#   ./result/bin/run-siraken-mba-vm   # DOTFILES_DIR=<checkout> to share another one
#
# Log in as the user with password "vm", or over SSH:
# `ssh -p 2222 siraken@localhost`. The disk image (siraken-mba.qcow2) is
# created in the current directory; delete it to start over.
{
  config,
  inputs,
  lib,
  userProfile,
  ...
}:
let
  # Only the desktop part of the user environment (./home.nix also brings the
  # standard profile and the coding agents): enough to try the desktop, and far
  # less to download and build.
  home = (import ../../lib/mk-home.nix { inherit inputs userProfile; }) {
    system = "x86_64-linux";
    homeModule = {
      imports = [
        ../../modules/home/mk-repo-link.nix
        ../../programs/hyprland
        ../../programs/wezterm
      ];
      dotfiles.linkMode = "outOfStore";
      home.stateVersion = "26.11";
    };
  };
in
{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 3072;
      cores = 2;
      diskSize = 8192;
      # Keep what the VM adds to the store on the disk image, like the home
      # directory: in tmpfs it is gone after a reboot while ~/.nix-profile still
      # points at it.
      writableStoreUseTmpfs = false;
      # virgl, so Hyprland has OpenGL.
      qemu.options = [
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
      # The out-of-store links (dotfiles.linkMode) point at ~/dotfiles. Mounted
      # outside the home directory, which a mount point inside it would create
      # owned by root before the user exists.
      sharedDirectories.dotfiles = {
        source = ''"''${DOTFILES_DIR:-$HOME/dotfiles}"'';
        target = "/mnt/dotfiles";
      };
      forwardPorts = [
        {
          from = "host";
          host.port = 2222;
          guest.port = 22;
        }
      ];
    };

    services.openssh.enable = true;

    systemd.tmpfiles.settings.vm-dotfiles."/home/${userProfile.username}/dotfiles"."L+".argument =
      "/mnt/dotfiles";

    # None of the real disks exist in the VM.
    boot.initrd.luks.devices = lib.mkForce { };
    swapDevices = lib.mkForce [ ];
    boot.resumeDevice = lib.mkForce "";

    users.users.${userProfile.username}.initialPassword = "vm";

    # The user environment is standalone home-manager; activate the desktop
    # part of it before the greeter so the first login already has it.
    systemd.services.home-manager-vm = {
      description = "Activate home-manager for the VM";
      wantedBy = [ "multi-user.target" ];
      before = [ "greetd.service" ];
      after = [
        "mnt-dotfiles.mount"
        "systemd-tmpfiles-setup.service"
      ];
      # The activation script calls nix-build and friends.
      path = [ config.nix.package ];
      serviceConfig = {
        Type = "oneshot";
        User = userProfile.username;
        ExecStart = "${home.activationPackage}/activate";
        RemainAfterExit = true;
      };
    };
  };
}
