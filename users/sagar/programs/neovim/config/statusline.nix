{
  config.vim = {
    statusline.lualine = {
      enable = true;
      theme = "auto";
    };

    tabline.nvimBufferline = {
      enable = true;
      setupOpts = {
        options = {
          offsets = [
            {
              filetype = "neo-tree";
              text = "File Explorer";
              highlight = "Directory";
              text_align = "left";
            }
          ];
        };
      };
    };
  };
}
