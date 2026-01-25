{
  pkgs,
  ...
}:
{

  imports = [
    ./modules
  ];
  home.packages = [ pkgs.dconf ];
  home.sessionVariables = {
    # Firefox Wayland fixes
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
  };
  targets.genericLinux.enable = true;
  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.papirus-icon-theme; # Replace with your chosen pack
      name = "Papirus"; # The exact name used by the theme
    };
  };
  # enable Hyprland
  home.stateVersion = "25.11";
}
