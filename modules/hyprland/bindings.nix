{
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    misc = {
      focus_on_activate = true;
      new_window_takes_over_fullscreen = 1;
    };
    bind = [

      # "SUPER SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"
      "SUPER, SPACE, exec, ~/.config/rofi/launchers/type-1/launcher.sh"
      "SUPER, F, fullscreen, 0" # Fullscreen (maximize)
      "SUPER, M, fullscreen, 1" # Maximize (keep gaps and bar)
      # "SUPER CTRL, SPACE, exec, ~/.local/share/omarchy/bin/swaybg-next"
      # "SUPER SHIFT CTRL, SPACE, exec, ~/.local/share/omarchy/bin/omarchy-theme-next"

      # Alt+Tab window switching
      "ALT, TAB, cyclenext" # Cycle to next window
      "ALT, TAB, bringactivetotop" # Bring it to front

      # Alt+Shift+Tab (reverse)
      "ALT SHIFT, TAB, cyclenext, prev" # Cycle to previous window
      "ALT SHIFT, TAB, bringactivetotop" # Bring it to front

      #Taking a screenshot
      "SUPER, PRINT, exec, hyprshot -m window"
      # Screenshot a monitor
      ", PRINT, exec, hyprshot -m output"
      # Screenshot a region
      "SUPER SHIFT, PRINT, exec, hyprshot -m region"

      # Launch file manager
      "SUPER, E, exec, $fileManager"
      "SUPER, B, exec, $browser"

      "SUPER, W, killactive,"
      "SUPER, RETURN, exec, $terminal"

      # End active session
      "SUPER SHIFT, DELETE, exec, hyprlock"
      "SUPER CTRL, ESCAPE, exec, reboot"
      "SUPER SHIFT CTRL, ESCAPE, exec, systemctl poweroff"
      "SUPER, ESCAPE, exec, wlogout"

      # Control tiling
      "SUPER, I, togglesplit, # dwindle"
      "SUPER, P, pseudo, # dwindle"
      "SUPER, T, togglefloating,"
      "SUPER SHIFT, Plus, fullscreen,"

      # Move focus with mainMod + arrow keys
      "SUPER, H,  movefocus, l"
      "SUPER, J,  movefocus, d"
      "SUPER, K,  movefocus, u"
      "SUPER, L,  movefocus, r"

      # Switch workspaces with mainMod + [0-9]
      "SUPER, 1, workspace, 1"
      "SUPER, 2, workspace, 2"
      "SUPER, 3, workspace, 3"
      "SUPER, 4, workspace, 4"
      "SUPER, 5, workspace, 5"
      "SUPER, 6, workspace, 6"
      "SUPER, 7, workspace, 7"
      "SUPER, 8, workspace, 8"
      "SUPER, 9, workspace, 9"
      "SUPER, 0, workspace, 10"

      "SUPER, comma, workspace, -1"
      "SUPER, period, workspace, +1"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "SUPER SHIFT, 1, movetoworkspace, 1"
      "SUPER SHIFT, 2, movetoworkspace, 2"
      "SUPER SHIFT, 3, movetoworkspace, 3"
      "SUPER SHIFT, 4, movetoworkspace, 4"
      "SUPER SHIFT, 5, movetoworkspace, 5"
      "SUPER SHIFT, 6, movetoworkspace, 6"
      "SUPER SHIFT, 7, movetoworkspace, 7"
      "SUPER SHIFT, 8, movetoworkspace, 8"
      "SUPER SHIFT, 9, movetoworkspace, 9"
      "SUPER SHIFT, 0, movetoworkspace, 10"

      # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
      "SUPER SHIFT, H, swapwindow, l"
      "SUPER SHIFT, L, swapwindow, r"
      "SUPER SHIFT, K, swapwindow, u"
      "SUPER SHIFT, J, swapwindow, d"

      # Resize active window
      "SUPER, minus, resizeactive, -100 0"
      "SUPER, equal, resizeactive, 100 0"
      "SUPER SHIFT, minus, resizeactive, 0 -100"
      "SUPER SHIFT, equal, resizeactive, 0 100"

      # Scroll through existing workspaces with mainMod + scroll
      "SUPER, mouse_down, workspace, e+1"
      "SUPER, mouse_up, workspace, e-1"

      # Control Apple Display brightness
      "CTRL, F1, exec, ~/.local/share/omarchy/bin/apple-display-brightness -5000"
      "CTRL, F2, exec, ~/.local/share/omarchy/bin/apple-display-brightness +5000"
      "SHIFT CTRL, F2, exec, ~/.local/share/omarchy/bin/apple-display-brightness +60000"

      # Super workspace floating layer
      "SUPER, S, togglespecialworkspace, magic"
      "SUPER SHIFT, S, movetoworkspace, special:magic"

      # Screenshots
      ", PRINT, exec, hyprshot -m region"
      "SHIFT, PRINT, exec, hyprshot -m window"
      "CTRL, PRINT, exec, hyprshot -m output"

      # Color picker
      "SUPER, PRINT, exec, hyprpicker -a"

      # Clipse
      "CTRL SUPER, V, exec, ghostty --class clipse -e clipse"
    ];

    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "SUPER, mouse:272, movewindow"
      "SUPER, mouse:273, resizewindow"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    bindd = [
      "SUPER, C, Universal copy, sendshortcut, CTRL, Insert"
      "SUPER, V, Universal paste, sendshortcut, SHIFT, Insert"
      "SUPER, X, Universal cut, sendshortcut, CTRL, X"
      "SUPER CTRL, V, Clipboard manager, exec, omarchy-launch-walker -m clipboard"
    ];
  };
}
