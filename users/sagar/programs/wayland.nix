{ ... }:

{
  home.sessionVariables = {
    # Chromium/Electron apps: Use Wayland
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # Firefox: Use Wayland
    MOZ_ENABLE_WAYLAND = "1";

    # GTK: Prefer Wayland, fallback to X11
    GDK_BACKEND = "wayland,x11";

    # Qt: Prefer Wayland, fallback to X11
    QT_QPA_PLATFORM = "wayland;xcb";

    # SDL: Use Wayland
    SDL_VIDEODRIVER = "wayland";

    # Clutter: Use Wayland
    CLUTTER_BACKEND = "wayland";
  };
}
