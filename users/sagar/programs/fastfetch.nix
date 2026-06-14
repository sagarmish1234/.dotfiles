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
        separator = " ▌ ";
        key = {
          width = 18;
        };
        bar = {
          char = {
            elapsed = "█";
            total = "░";
          };
          width = 25;
        };
      };

      # Modules: Cyberpunk MAGI / Unit-00 layout
      modules = [
        {
          type = "custom";
          format = "{#31}╔════════════════════════════════════════════════════════╗";
        }
        {
          type = "custom";
          format = "{#31}║ {#32}███╗   ██╗███████╗██████╗ ██╗   ██╗  {#33}EVA-00 SYSTEM     {#31}║";
        }
        {
          type = "custom";
          format = "{#31}║ {#32}████╗  ██║██╔════╝██╔══██╗██║   ██║  {#33}MAGI INTERFACE    {#31}║";
        }
        {
          type = "custom";
          format = "{#31}║ {#32}██╔██╗ ██║█████╗  ██████╔╝██║   ██║                    {#31}║";
        }
        {
          type = "custom";
          format = "{#31}║ {#32}██║╚██╗██║██╔══╝  ██╔══██╗╚██╗ ██╔╝  {#35}CLASSIFIED        {#31}║";
        }
        {
          type = "custom";
          format = "{#31}║ {#32}██║ ╚████║███████╗██║  ██║ ╚████╔╝   {#35}ACCESS ONLY       {#31}║";
        }
        {
          type = "custom";
          format = "{#31}║ {#32}╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝  ╚═══╝                      {#31}║";
        }
        {
          type = "custom";
          format = "{#31}╚════════════════════════════════════════════════════════╝";
        }
        {
          type = "custom";
          format = "{#33}▰▰▰▰ SYSTEM STATUS ▰▰▰▰";
        }
        {
          type = "os";
          key = "{#36}│ OS";
        }
        {
          type = "kernel";
          key = "{#36}│ KERNEL";
        }
        {
          type = "uptime";
          key = "{#36}│ UPTIME";
        }
        {
          type = "custom";
          format = "{#33}▰▰▰▰ USER DESIGNATION ▰▰▰▰";
        }
        {
          type = "users";
          key = "{#36}│ PILOT";
          format = "{name} @ {host-name}";
          myselfOnly = true;
        }
        {
          type = "localip";
          key = "{#36}│ NEURAL-LINK";
          format = "{ipv4}";
        }
        {
          type = "custom";
          format = "{#31}▰▰▰▰ RESOURCE METRICS ▰▰▰▰";
        }
        {
          type = "cpu";
          key = "{#33}│ CPU";
          format = "{name} ({cores-logical}T)";
        }
        {
          type = "memory";
          key = "{#33}│ LCL (RAM)";
          format = "{used} / {total}";
        }
        {
          type = "memory";
          key = "{#33}│ SYNC-RATE";
          percent = {
            type = [ "bar" "hide-others" ];
          };
        }
        {
          type = "disk";
          folders = "/";
          key = "{#33}│ ENTRY-PLUG";
          format = "{size-used} / {size-total}";
        }
        {
          type = "disk";
          folders = "/";
          key = "{#33}│ PLUG-DEPTH";
          percent = {
            type = [ "bar" "hide-others" ];
          };
        }
        {
          type = "custom";
          format = "{#32}          [PILOT READY FOR DEPLOYMENT]";
        }
      ];
    };
  };
}
