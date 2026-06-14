{ config, ... }:
{
  # Fastfetch: A fast, highly customizable system information tool.
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "small"; # Use the compact small NixOS logo
        color = {
          "1" = "#${config.lib.stylix.colors.base0D}"; # Stylix Blue
          "2" = "#${config.lib.stylix.colors.base0E}"; # Stylix Magenta
        };
        padding = {
          top = 2; # Push down to vertically center with the 11-line box
          left = 2;
          right = 3;
        };
      };

      display = {
        separator = " ";
      };

      # Modules: A single, compact ASCII border box aligned with the small logo
      modules = [
        {
          type = "custom";
          format = "╭───────────╮";
        }
        {
          type = "title";
          key = "│ {#31} user     {#keys}│";
          format = "{user-name}";
        }
        {
          type = "title";
          key = "│ {#32}󰇅 host     {#keys}│";
          format = "{host-name}";
        }
        {
          type = "os";
          key = "│ {#33} distro   {#keys}│";
        }
        {
          type = "kernel";
          key = "│ {#34} kernel   {#keys}│";
        }
        {
          type = "wm";
          key = "│ {#35} desktop  {#keys}│";
        }
        {
          type = "shell";
          key = "│ {#36} shell    {#keys}│";
        }
        {
          type = "cpu";
          key = "│ {#31} cpu      {#keys}│";
          format = "{name}";
        }
        {
          type = "memory";
          key = "│ {#32} memory   {#keys}│";
          format = "{used} / {total}";
        }
        {
          type = "disk";
          key = "│ {#33} disk     {#keys}│";
          folders = "/";
          format = "{size-used} / {size-total}";
        }
        {
          type = "custom";
          format = "╰───────────╯";
        }
      ];
    };
  };
}
