{ pkgs, lib, ... }:

{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    settings = {
      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        color-modes = true;
        
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = {
          hidden = false;
        };

        indent-guides = {
          render = true;
          character = "╎";
          skip-levels = 1;
        };

        statusline = {
          left = [ "mode" "spinner" "file-name" "read-only-indicator" "file-modification-indicator" ];
          center = [ "file-type" ];
          right = [ "diagnostics" "selections" "position" "file-encoding" ];
          mode = {
            normal = "NORMAL";
            insert = "INSERT";
            select = "SELECT";
          };
        };

        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };

      keys.normal = {
        space.space = "file_picker";
        space.w = ":w";
        space.q = ":q";
        esc = [ "collapse_selection" "keep_primary_selection" ];
      };
    };

    languages = {
      language = [
        {
          name = "nix";
          auto-format = true;
          formatter = {
            command = "nixfmt";
          };
        }
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "markdown";
          auto-format = true;
        }
      ];
    };

    extraPackages = with pkgs; [
      nil # Nix Language Server
      nixfmt-rfc-style # Nix formatter
      bash-language-server
      yaml-language-server
      marksman # Markdown LSP
    ];
  };
}
