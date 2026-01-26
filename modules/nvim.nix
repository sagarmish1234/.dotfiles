{ pkgs, ... }:
{

  programs.nvf = {
    enable = true;

    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.mini.animate.enable = true;
      vim.minimap.minimap-vim.enable = true;

      vim.dashboard.startify.enable = true;
      vim.statusline.lualine.enable = true;
      vim.tabline.nvimBufferline.enable = true;
      vim.filetree.neo-tree = {
        enable = true;
        setupOpts = {
          filesystem = {
            use_libuv_file_watcher = true; # Automatically watch for file changes
          };
        };
      };
      vim.telescope.enable = true;
      vim.binds.whichKey.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.snippets.luasnip.enable = true;
      vim.globals.mapleader = " ";
      vim.globals.maplocalleader = "\\";
      vim.keymaps = [
        {
          key = "<C-s>";
          mode = [
            "n"
            "i"
            "v"
          ]; # Normal, Insert, and Visual modes
          action = "<cmd>w<cr><esc>"; # Save and return to normal mode
          silent = true;
          desc = "Save file";
        }
        {
          key = "<C-h>";
          mode = "n";
          action = "<C-w>h";
          desc = "Go to Left Window";
        }
        {
          key = "<C-j>";
          mode = "n";
          action = "<C-w>j";
          desc = "Go to Lower Window";
        }
        {
          key = "<C-k>";
          mode = "n";
          action = "<C-w>k";
          desc = "Go to Upper Window";
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<C-w>l";
          desc = "Go to Right Window";
        }
      ];
      vim.terminal = {
        toggleterm = {
          enable = true;
          lazygit = {
            enable = true;
            mappings.open = "<leader>gg";

          }; # Adds <leader>gg for lazygit, just like LazyVim
          mappings = {
            open = "<C-`>"; # Default toggle key
          };
          setupOpts = {
            winbar.enabled = false;
            direction = "horizontal"; # Options: "horizontal", "vertical", "float"
          };
        };
      };
      vim.ui = {
        noice.enable = true; # Replaces the command line and adds popup alerts
        borders.enable = true; # Adds rounded borders to popups/LSP windows
        illuminate.enable = true; # Highlights other uses of the word under cursor
      };
      vim.options = {
        autoindent = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        shell = "${pkgs.fish}/bin/fish";
      };
      vim.visuals = {
        nvim-web-devicons.enable = true;
        indent-blankline.enable = true; # Adds the vertical indentation guides
      };
      vim.lsp = {
        enable = true;
        formatOnSave = true;
      };
      vim.languages = {
        enableTreesitter = true;
        enableFormat = true;
        # Replicate LazyVim language extras
        nix.enable = true;
        python.enable = true;
        rust.enable = true;
        ts.enable = true; # TypeScript
      };
    };
  };

}
