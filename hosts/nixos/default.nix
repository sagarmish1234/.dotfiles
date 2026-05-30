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

  # Use stable kernel for better NVIDIA compatibility.
  boot.kernelPackages = pkgs.linuxPackages;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken.
  system.stateVersion = "26.05";
}
