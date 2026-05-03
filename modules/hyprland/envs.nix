{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    # Environment variables
    env = [
      "GDK_SCALE, 1"

      # Cursor size
      "XCURSOR_SIZE,24"
      "HYPRCURSOR_SIZE,24"

      # Cursor theme
      "XCURSOR_THEME,Adwaita"
      "HYPRCURSOR_THEME,Adwaita"

      # Force all apps to use Wayland
      "GDK_BACKEND,wayland"
      "QT_QPA_PLATFORM,wayland"
      "QT_STYLE_OVERRIDE,kvantum"
      "SDL_VIDEODRIVER,wayland"
      "MOZ_ENABLE_WAYLAND,1"
      "ELECTRON_OZONE_PLATFORM_HINT,wayland"
      "OZONE_PLATFORM,wayland"

      # Make Chromium use XCompose and all Wayland
      "CHROMIUM_FLAGS,\"--enable-features=UseOzonePlatform --ozone-platform=wayland --gtk-version=4\""

      # Use XCompose file
      "XCOMPOSEFILE,~/.XCompose"
      "EDITOR,nvim"

      # GTK theme
      # "GTK_THEME, Adwaita:dark"

      # Podman compatibility. Probably need to add cfg.env?
      # "DOCKER_HOST,unix://$XDG_RUNTIME_DIR/podman/podman.sock"
    ];

    xwayland = {
      force_zero_scaling = true;
    };

    # Don't show update on first launch
    ecosystem = {
      no_update_news = true;
    };
  };
}
