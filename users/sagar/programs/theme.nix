{ pkgs, ... }:

{
  # Catppuccin global settings
  catppuccin.flavor = "mocha";
  catppuccin.accent = "lavender";
  catppuccin.enable = true;

  # GTK Configuration
  gtk = {
    enable = true;
    
    iconTheme = {
      name = pkgs.lib.mkForce "candy-icons";
      package = pkgs.lib.mkForce pkgs.candy-icons;
    };

    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  # Cursor theme
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaLavender;
    name = "catppuccin-mocha-lavender-cursors";
    size = 24;
    gtk.enable = true;
    x11.enable = true;
  };

  # Qt Configuration
  qt = {
    enable = true;
    platformTheme.name = "kvantum";
    style.name = "kvantum";
  };

  # Catppuccin specific program settings
  catppuccin.kvantum.enable = true;
  catppuccin.hyprland.enable = false;
  catppuccin.starship.enable = true;
  catppuccin.fish.enable = true;
  catppuccin.bat.enable = true;
  catppuccin.fzf.enable = true;
  catppuccin.yazi.enable = true;
  catppuccin.ghostty.enable = true;
  catppuccin.vscode.profiles.default.enable = true;
  catppuccin.mpv.enable = true;
}
