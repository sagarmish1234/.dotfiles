{
  pkgs,
  catppuccin,
  ...
}:
{

  imports = [
    ./modules
  ];
  catppuccin = {
    enable = true;
    flavor = "mocha";
  };
  home.packages = [ pkgs.dconf ];
  # gtk = {
  #   enable = true;
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome-themes-extra;
  #   };
  #   gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  #   gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
  # };

  # qt = {
  #   enable = true;
  #   style = {
  #     name = "adwaita-dark";
  #   };
  # };
  home.sessionVariables = {
    # Firefox Wayland fixes
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
  };
  targets.genericLinux.enable = true;
  # enable Hyprland
  home.stateVersion = "25.11";
}
