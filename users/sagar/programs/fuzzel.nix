{ config, pkgs, lib, ... }:

{
  # Fuzzel: A Wayland-native application launcher.
  # Customized with Tokyo Night theme colors.
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        font = "Outfit:size=13";
        dpi-aware = "no";
        prompt = "❯  ";
        icon-theme = "candy-icons";
        width = 35;
        horizontal-pad = 25;
        vertical-pad = 20;
        inner-pad = 12;
        line-height = 28;
        fields = "name,generic,comment,exec,categories,keywords";
        terminal = "ghostty --class=fuzzel-cli -e";
        layer = "overlay";
      };

      colors = {
        # Tokyo Night Theme Palette with ~86% opacity for the blur effect
        background = lib.mkForce "1a1b26dd";      # Tokyo Night Background
        text = lib.mkForce "c0caf5ff";            # Tokyo Night Foreground
        match = lib.mkForce "7aa2f7ff";           # Tokyo Night Primary (Blue)
        selection = lib.mkForce "24283bff";       # Tokyo Night Surface Variant
        selection-text = lib.mkForce "c0caf5ff";  # Tokyo Night Foreground
        selection-match = lib.mkForce "7aa2f7ff"; # Tokyo Night Primary
        border = lib.mkForce "7aa2f7ff";          # Tokyo Night Primary
      };

      border = {
        width = 2;
        radius = 7;
      };
    };
  };
}
