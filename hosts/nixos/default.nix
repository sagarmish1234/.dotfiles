{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/core
    ../../modules/core/secrets.nix
    ../../modules/core/nvidia.nix
    ../../modules/desktop
    ../../users/sagar
  ];

  # Host-specific settings
  networking.hostName = "nixos";
  networking.networkmanager.wifi.powersave = true;
  systemd.services.NetworkManager-wait-online.enable = false;

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.timeout = 1;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use XanMod kernel for better responsiveness.
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Modern initrd with systemd
  boot.initrd.systemd.enable = true;
  boot.initrd.verbose = false;
  boot.initrd.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];

  # Performance-oriented kernel parameters
  boot.kernelParams = [
    "quiet"
    "splash"
    "pcie_aspm=performance"
    "nvme_load=1"
    "fastboot"
    "nowatchdog"
    "nvidia-drm.modeset=1"
    "8250.nr_uarts=1"
    "tpm_tis.interrupts=0"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "26.05";
}
