{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
      "suppressevent maximize, class:.*"

      # Force chromium into a tile to deal with --app bug
      "tile, class:^(chromium)$"

      # Settings management
      "float, class:^(org.pulseaudio.pavucontrol|blueberry.py)$"

      # Float Steam, fullscreen RetroArch
      "float, class:^(steam)$"
      "fullscreen, class:^(com.libretro.RetroArch)$"

      # Float TUI windows
      "float, class:^(sagar\\.nixos\\..*)$"
      "size 70% 70%, class:^(sagar\\.nixos\\..*)$"
      "center, class:^(sagar\\.nixos\\..*)$"

      # Ensure terminal text is readable (Opaque text, transparent background handled by Ghostty)
      "opacity 1.0 1.0, class:^(com.mitchellh.ghostty|ghostty)$"

      # Just dash of transparency
      "opacity 0.97 0.9, class:.*"
      # Normal chrome Youtube tabs
      "opacity 1 1, class:^(chromium|google-chrome|google-chrome-unstable)$, title:.*Youtube.*"
      "opacity 1 0.97, class:^(chromium|google-chrome|google-chrome-unstable)$"
      "opacity 0.97 0.9, initialClass:^(chrome-.*-Default)$ # web apps"
      "opacity 1 1, initialClass:^(chrome-youtube.*-Default)$ # Youtube"
      "opacity 1 1, class:^(zoom|vlc|org.kde.kdenlive|com.obsproject.Studio)$"
      "opacity 1 1, class:^(com.libretro.RetroArch|steam)$"

      # Fix some dragging issues with XWayland
      "nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0"

      # Fix browser popups disappearing immediately
      "stayfocused, class:^$, title:^$"
      "noanim, class:^$, title:^$"
      "noinitialfocus, class:^$, title:^$"
      "float, class:^$, title:^$"
      "pin, class:^$, title:^$"
      "rounding 0, class:^$, title:^$"
      "noblur, class:^$, title:^$"
      "noshadow, class:^$, title:^$"
      "opacity 1.0 override 1.0 override, class:^$, title:^$"

      # Specifically for Zen
      "stayfocused, class:^zen-beta$, title:^$"
      "noanim, class:^zen-beta$, title:^$"
      "float, class:^zen-beta$, title:^$"
      "pin, class:^zen-beta$, title:^$"
      "noinitialfocus, class:^zen-beta$, title:^$"
      "opacity 1.0 override 1.0 override, class:^zen-beta$, title:^$"

      # Float in the middle for clipse clipboard manager
      "float, class:(clipse)"
      "size 622 652, class:(clipse)"
      "stayfocused, class:(clipse)"
    ];

    layerrule = [
      # Proper background blur for wofi
      "blur,rofi"
      # "blur,waybar"
    ];
  };
}
