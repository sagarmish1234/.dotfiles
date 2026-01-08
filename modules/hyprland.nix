{
  pkgs,
  ...
}:
{
  imports = [ ./hyprland/configuration.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config = {
      common.default = [ "gtk" ];
      hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.portal.FileChooser" = [ "gtk" ];
        "org.freedesktop.portal.OpenURI" = [ "gtk" ];
      };
    };
  };
  services.hyprpolkitagent.enable = true;
}
