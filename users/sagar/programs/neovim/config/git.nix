{
  config.vim = {
    git = {
      enable = true;
      gitsigns.enable = true;
    };

    terminal.toggleterm = {
      enable = true;
      lazygit.enable = true;
    };

    utility = {
      diffview-nvim.enable = true;
    };

    notes.todo-comments.enable = true;

    comments.comment-nvim = {
      enable = true;
      mappings = {
        toggleCurrentLine = "<leader>/";
        toggleSelectedLine = "<leader>/";
      };
    };
  };
}
