{ config, ... }:
{
  # Fastfetch: A fast, highly customizable system information tool.
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "kitty";
        source = "/home/sagar/Pictures/Wallpapers/anime_cafe_tokyonight.png";
        width = 28;
        height = 12;
        padding = {
          top = 1;
          left = 2;
          right = 3;
        };
      };

      display = {
        separator = "  ";
        color = {
          keys = "magenta";
          title = "#${config.lib.stylix.colors.base0D}"; # Stylix Accent/Blue
          separator = "#${config.lib.stylix.colors.base03}"; # Stylix Muted
        };
      };

      # Modules: Clean dashboard layout paired with the Kitty image logo
      modules = [
        "title"
        "separator"
        { type = "os"; key = "  OS"; }
        { type = "kernel"; key = "  Kernel"; }
        { type = "uptime"; key = "  Uptime"; }
        { type = "packages"; key = "󰏖  Packages"; }
        "break"
        { type = "wm"; key = "  WM"; }
        { type = "terminal"; key = "  Terminal"; }
        { type = "shell"; key = "  Shell"; }
        "break"
        { type = "cpu"; key = "  CPU"; temp = true; }
        { type = "gpu"; key = "󰍛  GPU"; temp = true; }
        {
          type = "memory";
          key = "  Memory";
          percent = {
            type = 3; # Bar & Percent
          };
        }
        {
          type = "disk";
          key = "  Disk";
          folders = "/";
          percent = {
            type = 3; # Bar & Percent
          };
        }
        "break"
        {
          type = "colors";
          symbol = "circle";
        }
      ];
    };
  };
}
