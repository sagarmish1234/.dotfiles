{ lib, ... }:

let
  inherit (lib.nvim.dag) entryAfter;
in
{
  config.vim = {
    luaConfigRC.theme-override = entryAfter [ "theme" ] ''
      -- Ensure visual selection is highlighted by reversing foreground and background
      vim.api.nvim_set_hl(0, "Visual", { reverse = true })
    '';
  };
}
