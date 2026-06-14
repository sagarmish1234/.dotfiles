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
        separator = " ";
      };

      # Modules: Catnap ASCII Border Box style on the right, paired with the Kitty image logo on the left
      modules = [
        {
          type = "custom";
          format = "╭───────────╮";
        }
        {
          type = "title";
          key = "│ {#31} user    {#keys}│";
          format = "{user-name}";
        }
        {
          type = "title";
          key = "│ {#32}󰇅 hname   {#keys}│";
          format = "{host-name}";
        }
        {
          type = "uptime";
          key = "│ {#33}󰅐 uptime  {#keys}│";
        }
        {
          type = "os";
          key = "│ {#34}󰣇 distro  {#keys}│";
        }
        {
          type = "kernel";
          key = "│ {#35} kernel  {#keys}│";
        }
        {
          type = "wm";
          key = "│ {#36} desktop {#keys}│";
        }
        {
          type = "terminal";
          key = "│ {#31} term    {#keys}│";
        }
        {
          type = "shell";
          key = "│ {#32} shell   {#keys}│";
        }
        {
          type = "cpu";
          key = "│ {#33} cpu     {#keys}│";
        }
        {
          type = "gpu";
          key = "│ {#34}󰍛 gpu     {#keys}│";
        }
        {
          type = "disk";
          key = "│ {#35}󰋊 disk    {#keys}│";
          folders = "/";
        }
        {
          type = "memory";
          key = "│ {#36} memory  {#keys}│";
        }
        {
          type = "custom";
          format = "├───────────┤";
        }
        {
          type = "colors";
          key = "│ {#39} colors  {#keys}│";
          symbol = "circle";
        }
        {
          type = "custom";
          format = "╰───────────╯";
        }
      ];
    };
  };
}
