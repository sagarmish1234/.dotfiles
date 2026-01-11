{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.desktop.notification.mako {
  # Mako notification daemon
  services.mako = {
    enable = true;
    settings = {

      # Catppuccin Mocha colors
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#89b4fa";
      progress-color = "over #313244";

      # Layout and positioning
      width = 400;
      height = 150;
      margin = "20";
      padding = "15";
      border-size = 2;
      border-radius = 12;

      # Icons
      icons = true;
      max-icon-size = 48;
      icon-path = "${pkgs.papirus-icon-theme}/share/icons/Papirus-Dark";

      # Behavior
      layer = "overlay";
      anchor = "top-right";

      # Font
      font = "JetBrains Mono 11";

      # Timing
      default-timeout = 5000; # 5 seconds
      ignore-timeout = false;

      # Max notifications
      max-visible = 5;

      # Sorting (time-ascending, time-descending, priority-ascending, priority-descending)
      sort = "-time";

      # Markup
      markup = true;

      # Actions
      actions = true;

      # Format
      format = "<b>%s</b>\\n%b";

      # Grouping
      group-by = "app-name";

      # Extra config for different urgency levels
    };
    extraConfig = ''
      [urgency=low]
      background-color=#1e1e2e
      text-color=#6c7086
      border-color=#313244
      default-timeout=3000

      [urgency=normal]
      background-color=#1e1e2e
      text-color=#cdd6f4
      border-color=#89b4fa
      default-timeout=5000

      [urgency=critical]
      background-color=#1e1e2e
      text-color=#f38ba8
      border-color=#f38ba8
      default-timeout=0
      ignore-timeout=1

      [app-name="Spotify"]
      border-color=#a6e3a1

      [app-name="Volume"]
      border-color=#fab387

      [app-name="Brightness"]
      border-color=#f9e2af

      [app-name="Battery"]
      border-color=#f38ba8

      [category=mpd]
      border-color=#cba6f7
    '';
  };

  # Hyprland integration
  wayland.windowManager.hyprland = {
    settings = {
      # Keybindings for notification control
      bind = [
        # Your existing bindings...

        # Dismiss last notification
        "SUPER, N, exec, makoctl dismiss"

        # Dismiss all notifications
        "SUPER SHIFT, N, exec, makoctl dismiss --all"

        # Invoke default action on last notification
        "SUPER CTRL, N, exec, makoctl invoke"

        # Show notification history
        "SUPER ALT, N, exec, makoctl restore"
      ];

      # Layer rules for mako
      layerrule = [
        "blur, notifications"
        "ignorealpha 0.2, notifications"
      ];
    };
  };

  # Install notification testing tools
  home.packages = with pkgs; [
    libnotify # For notify-send command
    papirus-icon-theme # Icon theme
  ];

  # Optional: Custom notification scripts
  home.file.".config/mako/scripts/test-notifications.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Test different notification types

      echo "Testing notifications..."

      # Normal notification
      notify-send "Normal Notification" "This is a normal priority notification"
      sleep 2

      # Low urgency
      notify-send -u low "Low Priority" "This is less important"
      sleep 2

      # Critical urgency
      notify-send -u critical "Critical Alert" "This is very important!"
      sleep 2

      # With icon
      notify-send -i dialog-information "With Icon" "This notification has an icon"
      sleep 2

      # With action
      notify-send -A "Open=xdg-open https://example.com" "Action Test" "Click to open link"
      sleep 2

      # Progress notification
      for i in {0..100..10}; do
        notify-send -h int:value:$i "Download Progress" "Downloading file... $i%"
        sleep 0.5
      done

      echo "Test complete!"
    '';
    executable = true;
  };

  # Volume notification helper script (optional)
  home.file.".config/mako/scripts/volume-notification.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Get volume percentage
      VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}')

      # Check if muted
      MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -o "MUTED")

      if [ "$MUTED" = "MUTED" ]; then
        notify-send -a "Volume" -u normal -h string:x-canonical-private-synchronous:volume \
          -h int:value:0 "Volume Muted" "🔇"
      else
        notify-send -a "Volume" -u normal -h string:x-canonical-private-synchronous:volume \
          -h int:value:"$VOLUME" "Volume" "🔊 $VOLUME%"
      fi
    '';
    executable = true;
  };

  # Brightness notification helper script (optional)
  home.file.".config/mako/scripts/brightness-notification.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Get brightness percentage
      BRIGHTNESS=$(brightnessctl get)
      MAX_BRIGHTNESS=$(brightnessctl max)
      PERCENT=$((BRIGHTNESS * 100 / MAX_BRIGHTNESS))

      notify-send -a "Brightness" -u normal -h string:x-canonical-private-synchronous:brightness \
        -h int:value:"$PERCENT" "Brightness" "☀️ $PERCENT%"
    '';
    executable = true;
  };
}
