{
  config.vim = {
    lsp = {
      enable = true;
      formatOnSave = true;
      trouble.enable = true;
      lspSignature.enable = true;
      lightbulb.enable = true;
      lspsaga.enable = true;
      lspkind.enable = true;
      nvim-docs-view.enable = true;
    };

    diagnostics = {
      enable = true;
      config = {
        virtual_text = {
          spacing = 4;
          prefix = "●";
        };
        underline = true;
        signs = true;
      };
    };

    debugger.nvim-dap = {
      enable = true;
      ui.enable = true;
    };
  };
}
