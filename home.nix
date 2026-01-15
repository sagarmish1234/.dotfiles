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
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  home.sessionVariables = {
    # Firefox Wayland fixes
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DBUS_REMOTE = "1";
  };
  targets.genericLinux.enable = true;
  # enable Hyprland
  home.stateVersion = "25.11";
}
