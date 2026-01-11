{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.waybar = {
    enable = true;
    # systemd = {
    #   enable = true;
    #   target = "graphical-session.target";
    # };

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 40;
        spacing = 8;
        margin-top = 8;
        margin-left = 12;
        margin-right = 12;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "pulseaudio"
          "cpu"
          "network"
          "bluetooth"
          "clock"
          "battery"
          "custom/notification"
        ];

        "hyprland/workspaces" = {
          format = "{name}";
          on-click = "activate";
          format-icons = {
            "*" = " ";
            default = " ";
          };
          sort-by-number = true;
          active-only = false;
          persistent-workspaces = {
            "*" = 5;
          };
        };

        "hyprland/window" = {
          format = "{}";
          max-length = 50;
          separate-outputs = true;
        };

        clock = {
          interval = 1;
          format = "{:%I:%M %p}";
          format-alt = "{:%A, %B %d, %Y (%R)}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#f5e0dc'><b>{}</b></span>";
              days = "<span color='#cdd6f4'><b>{}</b></span>";
              weeks = "<span color='#94e2d5'><b>W{}</b></span>";
              weekdays = "<span color='#f9e2af'><b>{}</b></span>";
              today = "<span color='#f38ba8'><b><u>{}</u></b></span>";
            };
          };
        };

        pulseaudio = {
          format = "{icon}";
          format-muted = "  muted";
          format-icons = {
            headphone = "🎧";
            headset = "";
            portable = "";
            car = "";
            hifi = "on";
            phone = "";
            default = [
              " "
              " "
              " "
            ];
          };
          on-click = "launch-tui wiremix";
          tooltip-format = "{desc} | {volume}%";
        };

        network = {
          format-wifi = " ";
          justify = "center";
          format-ethernet = " wired";
          format-disconnected = "󰤭 ";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)  | {ipaddr}";
          tooltip-format-ethernet = "{ifname} | {ipaddr}";
          on-click = "nm-connection-editor";
        };

        cpu = {
          interval = 2;
          format = "{icon}";
          format-icons = {
            default = [ " " ];
          };
          tooltip = true;
          on-click = "launch-tui btop --force-utf";
        };

        bluetooth = {
          format = "";
          format-off = "";
          format-on = "";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip = true;
          tooltip-format = "Controller: {controller_alias}\nAddress: {controller_address}\nStatus: {status}";
          tooltip-format-connected = "Controller: {controller_alias}\nAddress: {controller_address}\nConnected: {device_alias} ({device_address})\nBattery: {device_battery_percentage}%";
          on-click = "launch-tui bluetui";
          # "on-click-right "$HOME/.config/hypr/scripts/toggle_bluetooth.sh"
        };

        battery = {
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          format = "{capacity}% {icon}";
          format-full = "{capacity}% {icon}";
          format-charging = "{capacity}% ";
          format-plugged = "{capacity}% ";
          format-alt = "{time} {icon}";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };

        "custom/notification" = {
          tooltip = false;
          format = "{} {icon}";
          "format-icons" = {
            notification = "󱅫";
            none = "";
            "dnd-notification" = " ";
            "dnd-none" = "󰂛";
            "inhibited-notification" = " ";
            "inhibited-none" = "";
            "dnd-inhibited-notification" = " ";
            "dnd-inhibited-none" = " ";
          };
          "return-type" = "json";
          "exec-if" = "which swaync-client";
          exec = "swaync-client -swb";
          "on-click" = "sleep 0.1 && swaync-client -t -sw";
          "on-click-right" = "sleep 0.1 && swaync-client -d -sw";
          escape = true;
        };
      };
    };

    style = builtins.readFile ../config/waybar/style.css;
  };

  # Ensure dependencies are available in home.packages
  home.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    font-awesome
    wofi
    pavucontrol
    networkmanagerapplet
  ];
}
