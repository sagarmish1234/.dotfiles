{ lib, ... }:

let
  inherit (lib.nvim.dag) entryAfter;
in
{
  config.vim = {
    theme = {
      enable = true;
      name = "tokyonight";
      style = "night";
      transparent = true;
    };

    luaConfigRC.theme-override = entryAfter [ "theme" ] ''
      -- Ensure visual selection is highlighted by reversing foreground and background
      vim.api.nvim_set_hl(0, "Visual", { reverse = true })
    '';
  };
}
