{
  ...
}:
{
  imports = [ ./hyprland/configuration.nix ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  services.hyprpolkitagent.enable = true;
}
