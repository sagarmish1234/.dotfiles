{ lib, ... }:

let
  inherit (lib.nvim.dag) entryAfter;
in
{
  config.vim = {
    theme = {
      enable = true;
      name = "catppuccin";
      style = "mocha";
    };

    luaConfigRC.theme-override = entryAfter [ "theme" ] ''
      -- Custom highlight override for visual selection
      vim.api.nvim_set_hl(0, "Visual", { bg = "#585b70" })
    '';
  };
}
