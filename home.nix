{
  ...
}:
{

  imports = [
    ./modules/defaults.nix
  ];

  programs.fish = {
    enable = true;
    shellInit = "
      set fish_greeting
    ";
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
