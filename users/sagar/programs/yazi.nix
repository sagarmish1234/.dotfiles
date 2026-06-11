{
  lib,
  pkgs,
  config,
  ...
}:
let
  # Wrapped Package: Use symlinkJoin to provide a customized yazi package if needed.
  yazi-wrapped = pkgs.symlinkJoin {
    name = "yazi-wrapped";
    paths = [
      pkgs.yazi
    ];
  };
in
{
  # Packages: Extra tools used by Yazi (like exiftool for metadata).
  home.packages = [
    pkgs.exiftool
    yazi-wrapped
  ];

  programs = {
    # Shell Integration: Create 'yy' as a shortcut for Yazi.
    fish.functions = {
      yy = {
        body = "yazi";
        wraps = "yazi";
      };
    };

    bash.shellAliases = {
      yy = "yazi";
    };

    # Yazi: Modern terminal file manager with image preview support.
    yazi = {
      enable = true;
      package = yazi-wrapped;
      shellWrapperName = "y"; # Use 'y' to open yazi.

      flavors = {
        tokyo-night = pkgs.fetchFromGitHub {
          owner = "BennyOe";
          repo = "tokyo-night.yazi";
          rev = "main";
          sha256 = "039wyx3q1ws0hr9frc3lby967gl1fxyxd58b0q8y9v43sx3f22ic";
        };
      };

      theme = {
        flavor = {
          use = "tokyo-night";
        };
      };

      settings = {
        manager = {
          sort_by = "natural";
          sort_dir_first = true;
          show_hidden = false;
          show_symlink = true;
        };

        preview = {
          wrap = "no";
          tab_size = 2;
          max_width = 600;
          max_height = 900;
          image_filter = "triangle"; # Resizing algorithm.
          image_quality = 75;
          cache_dir = config.xdg.cacheHome;
        };

        # Git Integration: Fetch status for files and directories.
        plugin.prepend_fetchers = [
          {
            id = "git";
            url = "*";
            run = "git";
            group = "git";
          }
          {
            id = "git";
            url = "*/";
            run = "git";
            group = "git";
          }
        ];
      };

      # Plugins: Extend Yazi with extra functionality.
      plugins = {
        inherit (pkgs.yaziPlugins)
          chmod        # Change file permissions.
          full-border  # Add borders around the UI.
          git          # Show git status.
          toggle-pane  # Maximize/restore preview pane.
          mount        # Mount/unmount drives.
          starship     # Use starship prompt in yazi.
          ;
      };

      # Init: Run Lua code when Yazi starts.
      initLua = ''
        require("full-border"):setup()
        require("git"):setup()
        require("starship"):setup()
      '';

      keymap = {
        manager.prepend_keymap = [
          {
            on = "M";
            run = "plugin mount";
            desc = "Open mount";
          }
          {
            on = "T";
            run = "plugin toggle-pane max-preview";
            desc = "Maximize or restore the preview pane";
          }
          {
            on = [ "c" "m" ];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
          {
            on = [ "p" "s" ];
            run = ''shell 'du -sh "$@" | less' --block'';
            desc = "Calculate directory size";
          }
          {
            on = "<C-n>";
            run = ''shell '${lib.getExe pkgs.ripdrag} "$@" -x 2>/dev/null &' --confirm'';
            desc = "Drag and drop selected files";
          }
        ];
      };
    };
  };
}
