{ config, pkgs, lib, ... }:

{
  # Enable Niri window manager
  programs.niri.enable = true;

  # Display Manager Settings
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "sagar";

  # VM Variant resource settings
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096; # Allocate 4GB RAM
      cores = 4;         # Allocate 4 CPU cores
      # Enable virtio-vga-gl and GTK display with OpenGL context (required for Niri compositor to avoid blank/black screen)
      qemu.options = [
        "-device virtio-vga-gl"
        "-display gtk,gl=on"
      ];
    };
    # Override video drivers for QEMU compatibility (instead of Host's Nvidia driver)
    services.xserver.videoDrivers = lib.mkForce [ ];
    # Enable boot logs inside the VM on both serial port and screen for debugging
    boot.kernelParams = lib.mkForce [ "console=ttyS0,115200n8" "console=tty0" "loglevel=7" "show_status=true" ];

    # Auto-login root on serial console ttyS0 for interactive host debugging
    services.getty.autologinUser = lib.mkForce "root";
    systemd.services."serial-getty@ttyS0" = {
      enable = true;
      wantedBy = [ "getty.target" ];
      serviceConfig.Restart = "always";
    };
  };

  # XDG Portals configuration for Niri
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-gtk
    ];
    config.common.default = "*";
  };

  # Hint electron/ozone apps to run on Wayland natively
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
