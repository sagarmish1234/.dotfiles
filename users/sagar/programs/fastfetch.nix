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
        width = 32;
        height = 16;
        padding = {
          top = 1;
          left = 2;
          right = 3;
        };
      };

      display = {
        separator = " ";
      };

      # Modules: Structured dashboard boxes (2 & 3) paired with the Kitty image (4)
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
