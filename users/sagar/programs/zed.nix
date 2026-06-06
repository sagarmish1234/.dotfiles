{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "git-firefly"
    ];
    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 14;
      buffer_font_family = "JetBrainsMono Nerd Font";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = false;
      scrollbar = {
        show = "auto";
      };
      terminal = {
        font_family = "JetBrainsMono Nerd Font";
        font_size = 13;
      };
    };
  };

  # Enable the Catppuccin theme integration for Zed
  catppuccin.zed.enable = true;
}
