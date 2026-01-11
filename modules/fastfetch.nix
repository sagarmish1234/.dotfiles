{ ... }:
{
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "small";
        padding = {
          top = 1;
          left = 2;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "magenta";
          title = "#b4befe";
          separator = "#585b70";
        };
      };

      modules = [
        {
          type = "title";
          color = {
            user = "#b4befe";
            host = "#f5c2e7";
          };
        }

        "break"

        {
          type = "os";
          key = "󰣇 OS";
        }
        {
          type = "kernel";
          key = " Kernel";
        }
        {
          type = "uptime";
          key = "󰅐 Uptime";
        }

        "break"

        {
          type = "wm";
          key = " WM";
        }
        {
          type = "terminal";
          key = " Terminal";
        }
        {
          type = "shell";
          key = " Shell";
        }

        "break"

        {
          type = "cpu";
          key = " CPU";
        }
        {
          type = "gpu";
          key = "󰍛 GPU";
        }
        {
          type = "memory";
          key = "󰑭 Memory";
        }

        "break"

        {
          type = "disk";
          key = "󰋊 Disk";
          folders = [ "/" ];
        }

        "break"

        {
          type = "colors";
          symbol = "●";
        }
      ];
    };
  };
}
