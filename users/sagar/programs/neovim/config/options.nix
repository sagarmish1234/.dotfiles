{
  config.vim = {
    # Alias settings
    viAlias = true;
    vimAlias = true;

    session.nvim-session-manager.enable = true;

    # General vim options
    options = {
      # Indentation
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;
      expandtab = true;

      # Search
      ignorecase = true;
      smartcase = true;

      # UI
      number = true;
      relativenumber = true;
      termguicolors = true;
      signcolumn = "yes";
      scrolloff = 4;
      mouse = "a";

      # System
      undofile = true;
      clipboard = "unnamedplus";
    };
  };
}
