{
  config,
  pkgs,
  ...
}: {
  # Define Niri configuration via Home Manager xdg.configFile
  xdg.configFile."niri/config.kdl".text = ''
    // Input device configuration
    input {
        keyboard {
            xkb {
                layout "us"
                variant "altgr-intl"
                options "ctrl:nocaps"
            }
        }
        touchpad {
            tap
            natural-scroll
        }
        mouse {
            // accel-speed 0.2
        }
    }

    // Output settings - matches your laptop screen layout and scale
    output "eDP-1" {
        mode "1920x1080@144"
        scale 1.25
        position x=0 y=0
    }

    // Layout configuration
    layout {
        background-color "transparent"

        // Gap sizing
        gaps 8

        center-focused-column "never"

        preset-column-widths {
            proportion 0.33333
            proportion 0.5
            proportion 0.66667
        }

        default-column-width { proportion 0.5; }

        // Styled borders matching your Catppuccin theme (Lavender & Mauve linear gradient)
        border {
            width 2
            active-gradient from="#b4befe" to="#cba6f7" angle=45
            inactive-color "#313244"
        }

        focus-ring {
            off
        }
    }

    // Request client-side decorations to be omitted
    prefer-no-csd

    // Global blur configuration
    blur {
        passes 4
    }

    // Skip showing important hotkeys at startup
    hotkey-overlay {
        skip-at-startup
    }

    screenshot-path "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png"

    // Window and Layer Rules
    window-rule {
        match title="^launch-tui$"
        open-floating true
        default-column-width { proportion 0.7; }
        default-window-height { proportion 0.7; }
    }

    // layer-rule {
    //     match namespace="^noctalia.*$"
    //     background-effect {
    //         blur true
    //     }
    // }

    layer-rule {
        match namespace="^noctalia-overview.*$"
        place-within-backdrop true
    }

    // Enable premium rounded corners and background blur for all windows
    window-rule {
        geometry-corner-radius 7
        clip-to-geometry true
        background-effect {
            blur true
        }
        draw-border-with-background false
    }

    // Set transparency for active and inactive windows so blur is visible
    window-rule {
        match is-focused=false
        opacity 0.85
    }

    window-rule {
        match is-focused=true
        opacity 0.95
    }

    // Startup Applications
    spawn-at-startup "noctalia-shell"

    // Keybindings mapping your previous Hyprland hotkeys
    binds {
        // Show hotkey overlay (usually Mod+? on US keyboard)
        Mod+Shift+Slash { show-hotkey-overlay; }

        // Basic Controls
        Mod+Escape allow-inhibiting=false { spawn "noctalia-shell" "ipc" "call" "sessionMenu" "toggle"; }
        Mod+Return { spawn "ghostty"; }
        Mod+Space { spawn "noctalia-shell" "ipc" "call" "launcher" "toggle"; }
        Mod+Shift+W { spawn "noctalia-shell" "ipc" "call" "plugin:wallcards" "toggle"; }
        Mod+Shift+Q { quit; }
        Mod+W { close-window; }
        Mod+Q { close-window; }
        Mod+F { maximize-window-to-edges; }
        Mod+Shift+F { fullscreen-window; }
        Mod+M { maximize-column; }
        Mod+T { spawn "sh" "-c" "niri msg action toggle-window-floating && niri msg action center-window"; }
        Mod+Ctrl+L { spawn "loginctl" "lock-session"; }
        Mod+O repeat=false { toggle-overview; }

        // Vim-style Focus
        Mod+H { focus-column-left; }
        Mod+L { focus-column-right; }
        Mod+K { focus-window-up; }
        Mod+J { focus-window-down; }

        // Vim-style Window/Column Movement (similar to swapwindow in Hyprland)
        Mod+Shift+H { move-column-left; }
        Mod+Shift+L { move-column-right; }
        Mod+Shift+K { move-window-up; }
        Mod+Shift+J { move-window-down; }

        // Consume / Expel Window (Sensible defaults: BracketLeft/Right)
        Mod+BracketLeft  { consume-or-expel-window-left; }
        Mod+BracketRight { consume-or-expel-window-right; }

        // Workspace Navigation
        Mod+1 { focus-workspace 1; }
        Mod+2 { focus-workspace 2; }
        Mod+3 { focus-workspace 3; }
        Mod+4 { focus-workspace 4; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }

        // Move Window to Workspace (supporting both Mod+Shift and Mod+Ctrl for convenience)
        Mod+Shift+1 { move-column-to-workspace 1; }
        Mod+Shift+2 { move-column-to-workspace 2; }
        Mod+Shift+3 { move-column-to-workspace 3; }
        Mod+Shift+4 { move-column-to-workspace 4; }
        Mod+Shift+5 { move-column-to-workspace 5; }
        Mod+Shift+6 { move-column-to-workspace 6; }
        Mod+Shift+7 { move-column-to-workspace 7; }
        Mod+Shift+8 { move-column-to-workspace 8; }
        Mod+Shift+9 { move-column-to-workspace 9; }

        Mod+Ctrl+1 { move-column-to-workspace 1; }
        Mod+Ctrl+2 { move-column-to-workspace 2; }
        Mod+Ctrl+3 { move-column-to-workspace 3; }
        Mod+Ctrl+4 { move-column-to-workspace 4; }
        Mod+Ctrl+5 { move-column-to-workspace 5; }
        Mod+Ctrl+6 { move-column-to-workspace 6; }
        Mod+Ctrl+7 { move-column-to-workspace 7; }
        Mod+Ctrl+8 { move-column-to-workspace 8; }
        Mod+Ctrl+9 { move-column-to-workspace 9; }

        // Relative Workspace Switching
        Mod+Page_Down      { focus-workspace-down; }
        Mod+Page_Up        { focus-workspace-up; }
        Mod+U              { focus-workspace-down; }
        Mod+I              { focus-workspace-up; }
        Mod+Ctrl+Page_Down { move-column-to-workspace-down; }
        Mod+Ctrl+Page_Up   { move-column-to-workspace-up; }
        Mod+Ctrl+U         { move-column-to-workspace-down; }
        Mod+Ctrl+I         { move-column-to-workspace-up; }

        // Scroll wheel controls for Workspace/Column Switching
        Mod+WheelScrollDown      cooldown-ms=150 { focus-workspace-down; }
        Mod+WheelScrollUp        cooldown-ms=150 { focus-workspace-up; }
        Mod+Ctrl+WheelScrollDown cooldown-ms=150 { move-column-to-workspace-down; }
        Mod+Ctrl+WheelScrollUp   cooldown-ms=150 { move-column-to-workspace-up; }

        // Resize columns and windows
        Mod+Minus { set-column-width "-10%"; }
        Mod+Equal { set-column-width "+10%"; }
        Mod+Shift+Minus { set-window-height "-10%"; }
        Mod+Shift+Equal { set-window-height "+10%"; }

        // Multimedia keys (PipeWire / WirePlumber)
        XF86AudioRaiseVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "-l" "1.0"; }
        XF86AudioLowerVolume allow-when-locked=true { spawn "wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"; }
        XF86AudioMute        allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"; }
        XF86AudioMicMute     allow-when-locked=true { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86AudioPlay        allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioPause       allow-when-locked=true { spawn "playerctl" "play-pause"; }
        XF86AudioStop        allow-when-locked=true { spawn "playerctl" "stop"; }
        XF86AudioPrev        allow-when-locked=true { spawn "playerctl" "previous"; }
        XF86AudioNext        allow-when-locked=true { spawn "playerctl" "next"; }

        // Backlight keys (brightnessctl)
        XF86MonBrightnessUp   allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "+10%"; }
        XF86MonBrightnessDown allow-when-locked=true { spawn "brightnessctl" "--class=backlight" "set" "10%-"; }

        // Screenshots
        Mod+F5 { screenshot; }
        Print { screenshot; }
        Ctrl+Print { screenshot-screen; }
        Alt+Print { screenshot-window; }
    }
  '';
}
