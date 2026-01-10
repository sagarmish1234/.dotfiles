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
        ];

        "hyprland/workspaces" = {
          format = "{icon}";
          on-click = "activate";
          format-icons = {
            "1" = "一";
            "2" = "二";
            "3" = "三";
            "4" = "四";
            "5" = "五";
            "6" = "六";
            "7" = "七";
            "8" = "八";
            "9" = "九";
            "10" = "十";
            default = "";
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
      };
    };

    style = ''
      * {
        font-family: "JetBrainsMono Nerd Font", "Font Awesome 6 Free";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      /* Catppuccin Mocha Colors */
      @define-color base   #1e1e2e;
      @define-color mantle #181825;
      @define-color crust  #11111b;

      @define-color text     #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color subtext1 #bac2de;

      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color surface2 #585b70;

      @define-color overlay0 #6c7086;
      @define-color overlay1 #7f849c;
      @define-color overlay2 #9399b2;

      @define-color blue   #89b4fa;
      @define-color lavender #b4befe;
      @define-color sapphire #74c7ec;
      @define-color sky      #89dceb;
      @define-color teal     #94e2d5;
      @define-color green    #a6e3a1;
      @define-color yellow   #f9e2af;
      @define-color peach    #fab387;
      @define-color maroon   #eba0ac;
      @define-color red      #f38ba8;
      @define-color mauve    #cba6f7;
      @define-color pink     #f5c2e7;
      @define-color flamingo #f2cdcd;
      @define-color rosewater #f5e0dc;

      #workspaces,
      #window,
      #clock,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #temperature,
      #battery,
      #bluetooth,
      #tray,
      #custom-launcher,
      #custom-power {
        background: @base;
        color: @text;
        padding: 0px 16px;
        margin: 4px 0px;
        border-radius: 6px;
        border: 2px solid @surface0;
      }

      #custom-launcher {
        background: @blue;
        color: @crust;
        padding: 0px 18px;
        margin-right: 8px;
        font-size: 20px;
        border: none;
      }

      #custom-launcher:hover {
        background: @lavender;
      }

      #workspaces {
        padding: 0px 8px;
      }

      #workspaces button {
        padding: 0px 12px;
        color: @subtext0;
        border-radius: 8px;
        transition: all 0.3s ease;
      }

      #workspaces button.active {
        color: @blue;
        background: @surface0;
      }

      #workspaces button:hover {
        background: @surface1;
        color: @text;
      }

      #window {
        color: @mauve;
        font-weight: bold;
      }

      #clock {
        color: @sky;
        font-weight: bold;
        padding: 0px 20px;
      }

      #bluetooth {
        color: @blue;
      }

      #pulseaudio {
        color: @yellow;
      }

      #pulseaudio.muted {
        color: @red;
      }

      #network {
        color: @teal;
      }

      #network.disconnected {
        color: @red;
      }

      #cpu {
        color: @green;
      }

      #memory {
        color: @peach;
      }

      #temperature {
        color: @sapphire;
      }

      #temperature.critical {
        color: @red;
        animation: blink 0.5s linear infinite alternate;
      }

      #battery {
        color: @green;
      }

      #battery.charging, #battery.plugged {
        color: @teal;
      }

      #battery.warning:not(.charging) {
        color: @yellow;
      }

      #battery.critical:not(.charging) {
        color: @red;
        animation: blink 0.5s linear infinite alternate;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      #custom-power {
        background: @red;
        color: @crust;
        padding: 0px 18px;
        margin-left: 8px;
        font-size: 16px;
        border: none;
      }

      #custom-power:hover {
        background: @maroon;
      }

      @keyframes blink {
        to {
          opacity: 0.5;
        }
      }

      tooltip {
        background: @base;
        border: 2px solid @surface0;
        border-radius: 12px;
        padding: 10px;
      }

      tooltip label {
        color: @text;
      }
    '';
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
