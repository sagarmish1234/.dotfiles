{ pkgs, lib, ... }:

{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "git-firefly"
    ];
    userSettings = {
      ui_font_size = lib.mkForce 16;
      buffer_font_size = lib.mkForce 14;
      buffer_font_family = lib.mkForce "JetBrainsMono Nerd Font";
      telemetry = {
        diagnostics = false;
        metrics = false;
      };
      vim_mode = false;
      scrollbar = {
        show = "auto";
      };
      terminal = {
        font_family = lib.mkForce "JetBrainsMono Nerd Font";
        font_size = lib.mkForce 13;
      };
    };
  };
}
