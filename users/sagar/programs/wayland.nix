{ ... }:

{
  # Wayland Environment: Global variables to force applications to use native Wayland backends.
  home.sessionVariables = {
    # Chromium/Electron: Hint applications to use Wayland (OZONE).
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";

    # Firefox: Force Wayland backend.
    MOZ_ENABLE_WAYLAND = "1";

    # GTK: Prefer Wayland, fallback to X11 if unavailable.
    GDK_BACKEND = "wayland,x11";

    # Qt: Force Wayland with X11 fallback.
    QT_QPA_PLATFORM = "wayland;xcb";

    # Graphics Toolkits: Ensure SDL and Clutter use Wayland.
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };
}
