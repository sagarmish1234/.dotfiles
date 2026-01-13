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
  name = "launch-wallpaper";
  runtimeInputs = [
    awww
  ];
  text = ''
     awww-daemon
     WALLPAPER_DIR="${wallpaperDir}"
     STATE_FILE="${stateFile}"
     mkdir -p "$(dirname "$STATE_FILE")"
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
      NEXT_INDEX=$(( (CURRENT_INDEX) % ''${#WALLPAPERS[@]} ))
    else
      # First run, start with first wallpaper
      NEXT_INDEX=0
    fi
    NEXT_WALLPAPER="''${WALLPAPERS[$NEXT_INDEX]}"
    echo "$NEXT_WALLPAPER" > "$STATE_FILE"
    sleep 1 && ${awww}/bin/awww img "$NEXT_WALLPAPER" --transition-type wipe --transition-fps 30 --transition-duration 0
  '';
}
