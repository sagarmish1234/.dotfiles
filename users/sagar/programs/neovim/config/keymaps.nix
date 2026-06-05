{
  config.vim.keymaps = [
    # Window Navigation
    { key = "<C-h>"; mode = [ "n" ]; action = "<C-w>h"; desc = "Go to left window"; }
    { key = "<C-j>"; mode = [ "n" ]; action = "<C-w>j"; desc = "Go to lower window"; }
    { key = "<C-k>"; mode = [ "n" ]; action = "<C-w>k"; desc = "Go to upper window"; }
    { key = "<C-l>"; mode = [ "n" ]; action = "<C-w>l"; desc = "Go to right window"; }

    # Window Resizing
    { key = "<C-Up>"; mode = [ "n" ]; action = "<cmd>resize +2<cr>"; desc = "Increase window height"; }
    { key = "<C-Down>"; mode = [ "n" ]; action = "<cmd>resize -2<cr>"; desc = "Decrease window height"; }
    { key = "<C-Left>"; mode = [ "n" ]; action = "<cmd>vertical resize -2<cr>"; desc = "Decrease window width"; }
    { key = "<C-Right>"; mode = [ "n" ]; action = "<cmd>vertical resize +2<cr>"; desc = "Increase window width"; }

    # Buffer Navigation
    { key = "[b"; mode = [ "n" ]; action = "<cmd>bprevious<cr>"; desc = "Prev buffer"; }
    { key = "]b"; mode = [ "n" ]; action = "<cmd>bnext<cr>"; desc = "Next buffer"; }
    { key = "<leader>bb"; mode = [ "n" ]; action = "<cmd>Telescope buffers<cr>"; desc = "Switch to Buffer"; }
    { key = "<leader>bd"; mode = [ "n" ]; action = "<cmd>bdelete<cr>"; desc = "Delete Buffer"; }

    # File Explorer
    { key = "<leader>e"; mode = [ "n" ]; action = "<cmd>Neotree toggle<cr>"; desc = "Toggle Explorer (Neotree)"; }

    # Fuzzy Finder (Telescope)
    { key = "<leader>ff"; mode = [ "n" ]; action = "<cmd>Telescope find_files<cr>"; desc = "Find Files"; }
    { key = "<leader>fg"; mode = [ "n" ]; action = "<cmd>Telescope live_grep<cr>"; desc = "Live Grep"; }
    { key = "<leader>fr"; mode = [ "n" ]; action = "<cmd>Telescope oldfiles<cr>"; desc = "Recent Files"; }
    { key = "<leader>fc"; mode = [ "n" ]; action = "<cmd>Telescope grep_string<cr>"; desc = "Grep under cursor"; }
    { key = "<leader>fH"; mode = [ "n" ]; action = "<cmd>Telescope help_tags<cr>"; desc = "Help Tags"; }

    # Terminal
    { key = "<C-/>"; mode = [ "n" "t" ]; action = "<cmd>ToggleTerm<cr>"; desc = "Toggle Terminal"; }
    { key = "<leader>ft"; mode = [ "n" ]; action = "<cmd>ToggleTerm<cr>"; desc = "Toggle Terminal"; }

    # Git keybindings
    { key = "<leader>gd"; mode = [ "n" ]; action = "<cmd>DiffviewOpen<cr>"; desc = "Git Diffview Open"; }
    { key = "<leader>gH"; mode = [ "n" ]; action = "<cmd>DiffviewFileHistory<cr>"; desc = "Git File History"; }
    { key = "<leader>gc"; mode = [ "n" ]; action = "<cmd>DiffviewClose<cr>"; desc = "Git Diffview Close"; }
    { key = "<leader>ld"; mode = [ "n" ]; action = "<cmd>lua require('toggleterm.terminal').Terminal:new({ cmd = 'lazydocker', hidden = true, direction = 'float' }):toggle()<cr>"; desc = "Lazydocker"; }

    # Formatting
    { key = "<leader>cf"; mode = [ "n" "v" ]; action = "<cmd>lua vim.lsp.buf.format()<cr>"; desc = "Format Document"; }

    # LSP Navigation and Actions
    { key = "gd"; mode = [ "n" ]; action = "<cmd>lua vim.lsp.buf.definition()<cr>"; desc = "Go to Definition"; }
    { key = "gr"; mode = [ "n" ]; action = "<cmd>lua vim.lsp.buf.references()<cr>"; desc = "Go to References"; }
    { key = "gI"; mode = [ "n" ]; action = "<cmd>lua vim.lsp.buf.implementation()<cr>"; desc = "Go to Implementation"; }
    { key = "K"; mode = [ "n" ]; action = "<cmd>lua vim.lsp.buf.hover()<cr>"; desc = "Hover Info"; }
    { key = "<leader>cr"; mode = [ "n" ]; action = "<cmd>lua vim.lsp.buf.rename()<cr>"; desc = "Rename Symbol"; }
    { key = "<leader>ca"; mode = [ "n" "v" ]; action = "<cmd>lua vim.lsp.buf.code_action()<cr>"; desc = "Code Action"; }

    # Oil
    { key = "-"; mode = [ "n" ]; action = "<cmd>Oil<cr>"; desc = "Open parent directory in Oil"; }

    # Indent & Movement
    { key = "<"; mode = [ "v" ]; action = "<gv"; desc = "Indent left and keep selection"; }
    { key = ">"; mode = [ "v" ]; action = ">gv"; desc = "Indent right and keep selection"; }

    # Escape to clear highlights
    { key = "<esc>"; mode = [ "n" ]; action = "<cmd>noh<cr>"; desc = "Clear search highlight"; }
  ];
}
