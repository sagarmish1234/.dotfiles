{ config, pkgs, ... }:

{
  # Hyprland: Modern Wayland tiling window manager.
  programs.hyprland.enable = true;
  # XWayland: Allow X11 applications to run within the Wayland session.
  programs.hyprland.xwayland.enable = true;

  # Display Manager: Configure automatic login if needed.
  services.displayManager.autoLogin.enable = false;
  services.displayManager.autoLogin.user = "sagar";

  # XDG Portals: Provide communication between applications and the desktop environment.
  # Required for screen sharing, file pickers, and opening links.
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ]; # Specialized portal for Hyprland.
  };

  # Session Variables: Global environment settings for Wayland.
  environment.sessionVariables = {
    # NVIDIA fix: If the mouse cursor is invisible on NVIDIA hardware, this is usually required.
    WLR_NO_HARDWARE_CURSORS = "1";
    
    # Ozone: Hint Electron-based applications (Discord, VSCode) to use native Wayland.
    NIXOS_OZONE_WL = "1";
  };
}
