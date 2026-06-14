{ config, ... }:
{
  # Fastfetch: A fast, highly customizable system information tool.
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "small"; # Use a compact logo to save space.
        padding = {
          top = 1;
          left = 2;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "magenta";
          title = "#${config.lib.stylix.colors.base0D}"; # Stylix Accent/Blue.
          separator = "#${config.lib.stylix.colors.base03}"; # Stylix Muted.
        };
      };

      # Modules: Select which information to display.
      modules = [
        {
          type = "title";
          color = {
            user = "#${config.lib.stylix.colors.base0D}"; # Stylix Blue.
            host = "#${config.lib.stylix.colors.base0E}"; # Stylix Magenta.
          };
        }

        "break"

        { type = "os"; key = "󰣇 OS"; }
        { type = "kernel"; key = " Kernel"; }
        { type = "uptime"; key = "󰅐 Uptime"; }

        "break"

        { type = "wm"; key = " WM"; }
        { type = "terminal"; key = " Terminal"; }
        { type = "shell"; key = " Shell"; }

        "break"

        { type = "cpu"; key = " CPU"; }
        { type = "gpu"; key = "󰍛 GPU"; }
        { type = "memory"; key = "󰑭 Memory"; }

        "break"

        {
          type = "disk";
          key = "󰋊 Disk";
          folders = [ "/" ];
        }

        "break"

        {
          type = "colors";
          symbol = "●"; # Show the color palette as a row of dots.
        }
      ];
    };
  };
}
