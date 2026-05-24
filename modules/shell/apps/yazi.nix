{
  lib,
  pkgs,
  config,
  ...
}:
let
  yazi-script = pkgs.writeShellScriptBin "yazi" ''
    # Start rclone service if not active
    ${pkgs.systemd}/bin/systemctl --user is-active --quiet rclone-googledrive.service || ${pkgs.systemd}/bin/systemctl --user start rclone-googledrive.service

    # Run the real yazi
    ${pkgs.yazi}/bin/yazi "$@"

    # If this is the last yazi instance, stop the service
    if [ "$(${pkgs.procps}/bin/pgrep -u $(id -u) -x yazi | wc -l)" -le 1 ]; then
      ${pkgs.systemd}/bin/systemctl --user stop rclone-googledrive.service
    fi
  '';
  yazi-wrapped = pkgs.symlinkJoin {
    name = "yazi-wrapped";
    paths = [
      yazi-script
      pkgs.yazi
    ];
  };
in
{
  home.packages = [
    pkgs.exiftool
    yazi-wrapped
  ];
  programs = {
    fish.functions = {
      yy = {
        body = "yazi";
        wraps = "yazi";
      };
    };

    bash.shellAliases = {
      yy = "yazi";
    };

    yazi = {
      enable = true;
      package = yazi-wrapped;
      shellWrapperName = "y";

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
          image_filter = "triangle";
          image_quality = 75;
          cache_dir = config.xdg.cacheHome;
        };

        # for git plugin
        plugin.prepend_fetchers = [
          {
            id = "git";
            name = "*";
            run = "git";
          }
          {
            id = "git";
            name = "*/";
            run = "git";
          }
        ];
      };

      plugins = {
        inherit (pkgs.yaziPlugins)
          chmod
          full-border
          git
          toggle-pane
          mount
          starship
          ;
      };

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
            on = [
              "c"
              "m"
            ];
            run = "plugin chmod";
            desc = "Chmod on selected files";
          }
          {
            on = [ "g" "d" ];
            run = "cd ${config.home.homeDirectory}/GoogleDrive";
            desc = "Go to Google Drive";
          }
          {
            on = [ "p" "s" ];
            run = ''shell 'du -sh "$@" | less' --block'';
            desc = "Calculate directory size";
          }
          {
            on = "<C-n>";
            run = ''shell '${lib.getExe pkgs.ripdrag} "$@" -x 2>/dev/null &' --confirm'';
          }
        ];
      };
    };
  };
}
