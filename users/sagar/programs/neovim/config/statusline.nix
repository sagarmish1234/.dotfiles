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
          separator_style = "slant";
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
