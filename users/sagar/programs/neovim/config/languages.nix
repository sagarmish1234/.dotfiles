{
  config.vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # Supported languages
      nix = {
        enable = true;
        lsp.servers = [ "nixd" ];
      };
      markdown = {
        enable = true;
        lsp.servers = [ "marksman" ];
      };
      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html = {
        enable = true;
        lsp.servers = [ "superhtml" ];
      };
      json.enable = true;
      sql.enable = true;
      typescript.enable = true;
      go.enable = true;
      lua.enable = true;
      python = {
        enable = true;
        lsp.servers = [ "basedpyright" "ruff" ];
      };
      rust.enable = true;
      svelte.enable = true;
    };

    treesitter.context.enable = true;
  };
}
