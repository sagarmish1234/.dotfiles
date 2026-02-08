{
  pkgs,
  lib,
  feature,
  ...
}:
lib.mkIf feature.editor.nvim {
  programs.nvf = {
    enable = true;

    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.mini.animate.enable = false;
      vim.minimap.codewindow.enable = true;
      vim.minimap.minimap-vim.enable = true;
      vim.utility.direnv.enable = true;
      vim.autopairs.nvim-autopairs = {
        enable = true;
        # Optional: configure nvim-autopairs specific options
        setupOpts = {
          check_ts = true; # Enable Treesitter integration for smarter pairing
          disable_filetype = ["TelescopePrompt"]; # Avoid double-closing in search
        };
      };

      vim.dashboard = {
        alpha = {
          enable = true;
          # Choose a theme: "dashboard" (standard), "startify", or "theta"
          # "theta" is a modern theme with recent files and status info.
          theme = "theta";
        };
      };
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
          key = "gd";
          mode = "n";
          action = ":Telescope lsp_definitions<CR>";
          desc = "Go to Definition";
        }

        {
          key = "gr";
          mode = "n";
          action = ":Telescope lsp_references<CR>";
          desc = "Go to References";
        }

        {
          key = "gi";
          mode = "n";
          action = ":Telescope lsp_implementations<CR>";
          desc = "Go to Implementations";
        }

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

        {
          key = "<leader>e";
          mode = "n";
          action = ":Neotree filesystem toggle<CR>";
          desc = "Toggle Neotree";
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
      vim.git = {
        enable = true;
        gitsigns.enable = true;
        gitsigns.codeActions.enable = true; # Allows staging hunks directly
      };
      vim.options = {
        autoindent = true;
        smartindent = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        shell = "${pkgs.fish}/bin/fish";
        clipboard = "unnamedplus";
      };
      vim.visuals = {
        nvim-web-devicons.enable = true;
        indent-blankline.enable = true; # Adds the vertical indentation guides
      };
      vim.lsp = {
        enable = true;
        formatOnSave = true;
        lspconfig.enable = true;
        lspconfig.sources.pyright = ''
          lspconfig.pyright.setup({
            settings = {
              python = {
                -- Automatically use the python from your nix develop/direnv shell
                pythonPath = vim.fn.exepath('python'),
                analysis = {
                  autoSearchPaths = true,
                  useLibraryCodeForTypes = true,
                  diagnosticMode = "workspace",
                },
              },
            },
            on_init = function(client)
              local nix_python = vim.fn.exepath('python')
              if nix_python ~= "" then
                client.config.settings.python.pythonPath = nix_python
                client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
              end
            end,
          })
        '';
      };
      vim.languages = {
        enableTreesitter = true;
        enableFormat = true;
        # Replicate LazyVim language extras
        nix = {
          enable = true;
          lsp = {
            servers = ["nixd"];
          };
        };
        python = {
          enable = true;
          lsp.servers = ["pyright"];
        };
        java.enable = true;
        rust.enable = true;
        ts.enable = true; # TypeScript
        typst.enable = true;
        qml.enable = true;
      };
    };
  };
}
