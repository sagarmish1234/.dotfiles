{
  pkgs,
  inputs,
  ...
}:

{
  # Install awww
  home.packages = with pkgs; [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
  ];

  # Ensure wallpaper directory exists
  home.file."Pictures/Wallpapers/.keep".text = "";

  # Optional: Download a Catppuccin Mocha wallpaper
  home.file."Pictures/Wallpapers/Clearday.jpg".source = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/Clearday.jpg?raw=true";
    sha256 = "sha256-jAueWsy2a9tr3hguYktAh7d9EcSBeFOjDn4BZSDPqJQ=";
    # Run: nix-prefetch-url <url>
  };

  home.file."Pictures/Wallpapers/shaded_landscape.png".source = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/shaded_landscape.png?raw=true";
    sha256 = "sha256-EZmkN1HxI00/uS7PYU+/NN4sBzNNP901WJEET1G92to=";
  };
  home.file."Pictures/Wallpapers/Cloudsnight.jpg".source = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/Cloudsnight.jpg?raw=true";
    sha256 = "sha256-jBv9iKBVQbgd1cmv+ubiJQH7qydRJZTShmwzEiJJcDA=";
    # Run: nix-prefetch-url <url>
  };

  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Start awww daemon on Hyprland startup
      exec-once = [
        "awww-daemon"
        # Wait a moment for daemon to start, then set wallpaper
        "sleep 1 && awww img ~/Pictures/Wallpapers/Clearday.jpg --transition-type wipe --transition-fps 60 --transition-duration 2"
      ];

      bind = [
        # Optional: Add wallpaper switcher binding
        "SUPER SHIFT, W, exec, ~/.config/hypr/scripts/wallpaper-switcher.sh"
      ];
    };
  };

  # Wallpaper switcher script (optional but recommended)
  home.file.".config/hypr/scripts/wallpaper-switcher.sh" = {
    text = ''
      #!/usr/bin/env bash

      WALLPAPER_DIR="$HOME/Pictures/Wallpapers"
      STATE_FILE="$HOME/.cache/swww_current_wallpaper"

      # Create cache directory if it doesn't exist
      mkdir -p "$(dirname "$STATE_FILE")"

      # Select random wallpaper
      mapfile -t WALLPAPERS < <(find "$WALLPAPER_DIR" -iname "*.jpg" -o -iname "*.png" -o -iname "*.gif"  | sort)

      if [ ''${#WALLPAPERS[@]} -eq 0 ]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
      fi

       # Get current wallpaper index
      if [ -f "$STATE_FILE" ]; then
        CURRENT_WALLPAPER=$(cat "$STATE_FILE")
        CURRENT_INDEX=-1

        # Find current wallpaper index
        for i in "''${!WALLPAPERS[@]}"; do
          if [ "''${WALLPAPERS[$i]}" = "$CURRENT_WALLPAPER" ]; then
            CURRENT_INDEX=$i
            break
          fi
        done

        # Get next index (cycle back to 0 if at end)
        NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ''${#WALLPAPERS[@]} ))
      else
        # First run, start with first wallpaper
        NEXT_INDEX=0
      fi

      # Get next wallpaper
      NEXT_WALLPAPER="''${WALLPAPERS[$NEXT_INDEX]}"

      # Set wallpaper with smooth transition
      awww img "$NEXT_WALLPAPER" \
        --transition-type grow \
        --transition-fps 45 \
        --transition-duration 2

      echo "$NEXT_WALLPAPER" > "$STATE_FILE"
      # Send notification (requires mako or dunst)
      # notify-send "Wallpaper Changed" "$(basename "$WALLPAPER")"
    '';
    executable = true;
  };

  # Quick wallpaper changer script with specific transitions
  home.file.".config/hypr/scripts/awww-set.sh" = {
    text = ''
      #!/usr/bin/env bash

      # Usage: awww-set.sh /path/to/wallpaper.png [transition-type]

      WALLPAPER="$1"
      TRANSITION="''${2:-wipe}"  # Default to wipe if not specified

      if [ -z "$WALLPAPER" ]; then
        echo "Usage: $0 <wallpaper-path> [transition-type]"
        echo "Available transitions: simple, fade, wipe, grow, outer, wave, random"
        exit 1
      fi

      # Set wallpaper with specified transition
      awww img "$WALLPAPER" \
        --transition-type "$TRANSITION" \
        --transition-fps 60 \
        --transition-duration 2 \
        --transition-bezier 0.4,0.0,0.2,1
    '';
    executable = true;
  };
}
