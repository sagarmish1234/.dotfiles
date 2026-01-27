{pkgs, ...}: {
  imports = [
    ./modules
  ];
  home.packages = [pkgs.dconf];
  home.sessionVariables = {
    # Firefox Wayland fixes
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
  };
  targets.genericLinux.enable = true;
  gtk = {
    enable = true;
    theme = {
      package = pkgs.orchis-theme;
      name = "Orchis-Green";
    };
    iconTheme = {
      package = pkgs.oranchelo-icon-theme; # Replace with your chosen pack
      name = "Oranchelo-Classic-Folders"; # The exact name used by the theme
    };
  };
  # enable Hyprland
  home.stateVersion = "25.11";
}
