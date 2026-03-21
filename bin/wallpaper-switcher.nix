{
  pkgs,
  inputs,
  wallpaper_config,
  ...
}:
let
  awww = inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww;
  stateFile = wallpaper_config.stateFile;
  wallpaperDir = wallpaper_config.wallpaperDir;
in
pkgs.writeShellApplication {
  name = "wallpaper-switcher";
  runtimeInputs = [
    awww
  ];
  text = ''
    WALLPAPER_DIR="${wallpaperDir}"
    STATE_FILE="${stateFile}"
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
    mkdir -p "$HOME/.cache"
    ln -sf "$NEXT_WALLPAPER" "$HOME/.cache/current_wallpaper"
  '';
}
