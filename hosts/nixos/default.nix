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

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use XanMod kernel for better responsiveness.
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Performance-oriented kernel parameters
  boot.kernelParams = [
    "quiet"
    "splash"
    "pcie_aspm=performance"
    "nvme_load=1"
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "26.05";
}
