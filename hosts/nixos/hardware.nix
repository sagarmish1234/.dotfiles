# Hardware Configuration - Auto-generated and customized.
# This file contains the results of the hardware scan (nixos-generate-config).
# It defines the filesystems, kernel modules, and hardware-specific settings.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [ (modulesPath + "/installer/scan/not-detected.nix")
    ];

  # Boot: Essential kernel modules for hardware detection during the initial boot phase.
  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" "sd_mod" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ]; # Enable KVM virtualization for Intel CPUs.
  boot.extraModulePackages = [ ];

  # Filesystems: Defined by UUID to ensure they are found regardless of disk order.
  # We use Btrfs for advanced features like subvolumes and compression.
  
  # Root Partition (/)
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/9971bff8-2804-4f06-9967-f94c68511c86";
      fsType = "btrfs";
    };

  # Home Subvolume (/home)
  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/9971bff8-2804-4f06-9967-f94c68511c86";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

  # Nix Store Subvolume (/nix)
  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/9971bff8-2804-4f06-9967-f94c68511c86";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

  # Boot Partition (/boot)
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/41CC-2F1B";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

  swapDevices = [ ]; # No physical swap partition; using ZRAM (configured in performance.nix).

  # Platform: Architecture settings.
  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  # Microcode: Ensure Intel CPU security and performance patches are loaded at boot.
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
