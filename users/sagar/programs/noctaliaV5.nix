{
  inputs,
  pkgs,
  ...
}: let
  # noctalia-plugins-src = pkgs.fetchFromGitHub {
  #   owner = "whereareiam";
  #   repo = "noctalia-plugins";
  #   rev = "release";
  #   hash = "sha256-n3SIMQxeB/ADMsGA3CJDIgx7FhfXiFh4mFXkwo+sCy0=";
  # };
  #
  # noctalia-official-plugins-src = pkgs.fetchFromGitHub {
  #   owner = "noctalia-dev";
  #   repo = "noctalia-plugins";
  #   rev = "main";
  #   hash = "sha256-jOHmyhHBEk4CjiroB6Ju+5mml1uQtGfMjcuu1fhCSfs=";
  # };
  #
  # hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  # jq = "${pkgs.jq}/bin/jq";
  #
  # # Dedicated script to handle window switching with fullscreen preservation
  # switch-script = pkgs.writeShellScript "tabber-focus-switch" ''
  #   TARGET="$1"
  #   # Ensure address starts with 0x
  #   [[ "$TARGET" != 0x* ]] && TARGET="0x$TARGET"
  #
  #   # Get current active window's fullscreen state
  #   FW=$(${hyprctl} activewindow -j | ${jq} -r '.fullscreen // 0')
  #
  #   # If activewindow is 0 (e.g. switcher took focus), try to find the most recently active client
  #   if [ "$FW" -eq 0 ]; then
  #      FW=$(${hyprctl} clients -j | ${jq} -r '.[] | select(.focusHistoryID == 0) | .fullscreen // 0')
  #   fi
  #
  #   # Focus the target window
  #   ${hyprctl} dispatch focuswindow "address:$TARGET"
  #
  #   # Wait for Hyprland to process focus change
  #   sleep 0.12
  #
  #   # Check target window's current state to avoid accidental toggling
  #   NEW_FW=$(${hyprctl} clients -j | ${jq} -r ".[] | select(.address == \"$TARGET\") | .fullscreen // 0")
  #
  #   # Only apply if previous window was fullscreen and target is not
  #   if [ "$FW" -ne 0 ] && [ "$FW" -ne "$NEW_FW" ]; then
  #       ${hyprctl} dispatch fullscreen "$FW"
  #   fi
  #
  #   # Bring to top
  #   ${hyprctl} dispatch alterzorder "top,address:$TARGET"
  # '';
  #
  # oldLine = ''Quickshell.execDetached(["bash", "-lc", "sleep 0.08; hyprctl dispatch focuswindow 'address:" + windowAddress + "' >/dev/null 2>&1 || true; hyprctl dispatch alterzorder 'top,address:" + windowAddress + "' >/dev/null 2>&1 || true"]);'';
  # newLine = ''Quickshell.execDetached(["${switch-script}", windowAddress]);'';
  #
  # noctalia-plugins =
  #   pkgs.runCommand "noctalia-plugins-patched"
  #   {
  #     inherit oldLine newLine;
  #   }
  #   ''
  #     cp -r ${noctalia-plugins-src} $out
  #     chmod -R +w $out
  #     substituteInPlace $out/tabber/Services/TabberController.qml \
  #       --replace-fail "$oldLine" "$newLine"
  #   '';
in {
  imports = [
    inputs.noctaliaV5.homeModules.default
  ];

  # xdg.configFile."noctalia/plugins/tabber".source = "${noctalia-plugins}/tabber";
  # xdg.configFile."noctalia/plugins/wallcards".source = "${noctalia-official-plugins-src}/wallcards";
  # xdg.configFile."noctalia/plugins.json".text = builtins.toJSON {
  #   sources = [
  #     {
  #       enabled = true;
  #       name = "Noctalia Plugins";
  #       url = "https://github.com/noctalia-dev/noctalia-plugins";
  #     }
  #     {
  #       enabled = true;
  #       name = "Tabber";
  #       url = "https://github.com/whereareiam/noctalia-plugins";
  #     }
  #   ];
  #   states = {
  #     tabber = {
  #       enabled = true;
  #     };
  #     wallcards = {
  #       enabled = true;
  #     };
  #   };
  #   version = 2;
  # };
  programs.noctalia = {
    enable = true;

    settings = {
      # This may also be a string or path to a .toml file.
      theme = {
        mode = "dark";
        source = "builtin";
        builtin = "Catppuccin";
      };
      shell = {
        corner_radius_scale = 1.25;
        font_family = "JetBrainsMono Nerd Font";

        shadow = {
          direction = "down";
          alpha = 0.52;
        };

        panel = {
          background_blur = true;
          transparency_mode = "glass";
          borders = true;
          shadow = true;
          launcher_placement = "centered";
          clipboard_placement = "centered";
          control_center_placement = "attached";
          wallpaper_placement = "centered";
          session_placement = "centered";
        };
      };

      backdrop = {
        enabled = true;
        blur_intensity = 0.85;
        tint_intensity = 0.45;
      };
      wallpaper = {
        enabled = true;
        fill_mode = "crop";
        transition = [
          # "fade"
          # "wipe"
          "disc"
          # "stripes"
          # "zoom"
          # "honeycomb"
        ];
        transition_duration = 1500;
        edge_smoothness = 0.3;
        directory = "~/Pictures/Wallpapers";
      };
      bar.default = {
        background_opacity = 0.58;
        radius = 18;
        margin_ends = 8;
        margin_edge = 10;
        shadow = true;
        scale = 1.15;
        start = [
          "wallpaper"
          "workspaces"
          "active_window"
          "media"
        ];
        center = [
          "clock"
        ];
        end = [
          "tray"
          "notifications"
          "network"
          "bluetooth"
          "volume"
          "brightness"
          "battery"
          "screenshot"
          "control-center"
          "session"
        ];
      };
      widget.workspaces = {
        type = "workspaces";
        minimal = false;
        display = "id";
      };
      widget.active_window = {
        type = "active_window";
        display = "icon_only";
        icon_size = 20.0;
      };
      widget.network = {
        type = "network";
        show_label = false;
      };
      widget.bluetooth = {
        type = "bluetooth";
        show_label = false;
      };
      widget.volume = {
        type = "volume";
        show_label = false;
      };
      widget.brightness = {
        type = "brightness";
        show_label = false;
      };
      widget.battery = {
        type = "battery";
        show_label = false;
      };

      notification.background_opacity = 0.78;
      osd.background_opacity = 0.78;
    };
  };
}
