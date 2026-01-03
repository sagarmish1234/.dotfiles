{...}:{
  programs.fastfetch = {
    enable = true;
    settings = {
      logo =  {
        source = "nixos_large";
        padding =  {
          top =  2;
          right =  6;
          left =  2;
        };
      };
      modules =  [
        "break"
        {
          type = "custom";
          format =  "┌──────────────────────Hardware──────────────────────┐";
          keyColor =  "green";
        }
        {
          type =  "host";
          key =  " PC";
          keyColor =  "green";
        }
        {
          type =  "cpu";
          key =  "│ ├";
          showPeCoreCount =  true;
          keyColor =  "green";
        }
        {
          type =  "gpu";
          key =  "│ ├";
          detectionMethod =  "pci";
          keyColor =  "green";
        }
        {
          type =  "display";
          key =  "│ ├󱄄";
          keyColor =  "green";
        }
        {
          type =  "disk";
          key =  "│ ├󰋊";
          keyColor =  "green";
        }
        {
          type =  "memory";
          key =  "│ ├";
          keyColor =  "green";
        }
        {
          type =  "swap";
          key =  "└ └󰓡 ";
          keyColor =  "green";
        }
        {
          type =  "custom";
          format =  "└────────────────────────────────────────────────────┘";
          keyColor =  "green";
        }
        "break"
        {
          type =  "custom";
          format =  "┌──────────────────────Software──────────────────────┐";
          keyColor =  "blue";
        }
        
        {
          type =  "kernel";
          key =  "│ ├";
          keyColor =  "blue";
        }
        {
          type =  "wm";
          key =  "│ ├";
          keyColor =  "blue";
        }
        {
          type =  "de";
          key =  " DE";
          keyColor =  "blue";
        }
        {
          type =  "terminal";
          key =  "│ ├";
          keyColor =  "blue";
        }
        {
          type =  "packages";
          key =  "│ ├󰏖";
          keyColor =  "blue";
        }
        {
          type =  "wmtheme";
          key =  "│ ├󰉼";
          keyColor =  "blue";
        }
        {
          type =  "terminalfont";
          key =  "└ └";
          keyColor =  "blue";
        }
        {
          type =  "custom";
          format =  "└────────────────────────────────────────────────────┘";
          keyColor =  "blue";
        }
        "break"
        {
          type =  "custom";
          format =  "┌────────────────Age / Uptime / Update───────────────┐";
          keyColor =  "magenta";
        }
        {
          type =  "uptime";
          key =  "󱫐 Uptime";
          keyColor =  "magenta";
        }
        {
          type =  "custom";
          format =  "└────────────────────────────────────────────────────┘";
          keyColor =  "magenta";
        }
        "break"
      ];
    };
  };
}