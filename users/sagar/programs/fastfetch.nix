{ config, ... }:
{
  # Fastfetch: A fast, highly customizable system information tool.
  programs.fastfetch = {
    enable = true;
    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "builtin";
        color = {
          "1" = "#${config.lib.stylix.colors.base0D}"; # Stylix Blue
          "2" = "#${config.lib.stylix.colors.base0E}"; # Stylix Magenta
        };
        padding = {
          top = 2;
          left = 2;
          right = 3;
        };
      };

      display = {
        separator = " ";
      };

      # Modules: Structured dashboard boxes (2 & 3) paired with the customized NixOS ASCII (4)
      modules = [
        {
          type = "custom";
          format = "╭─ Hardware ╮";
        }
        {
          type = "cpu";
          key = "│ {#33} cpu      {#keys}│";
          format = "{name}";
        }
        {
          type = "gpu";
          key = "│ {#34}󰍛 gpu      {#keys}│";
          format = "{name}";
        }
        {
          type = "disk";
          key = "│ {#35} disk     {#keys}│";
          folders = "/";
          format = "{size-used} / {size-total} ({size-percentage}%)";
        }
        {
          type = "memory";
          key = "│ {#36} memory   {#keys}│";
          format = "{used} / {total} ({percentage}%)";
        }
        {
          type = "custom";
          format = "╰───────────╯";
        }
        
        "break"

        {
          type = "custom";
          format = "╭─ System ──╮";
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
          type = "terminal";
          key = "│ {#36} terminal {#keys}│";
        }
        {
          type = "shell";
          key = "│ {#31} shell    {#keys}│";
        }
        {
          type = "uptime";
          key = "│ {#32}󰅐 uptime   {#keys}│";
        }
        {
          type = "custom";
          format = "╰───────────╯";
        }
      ];
    };
  };
}
