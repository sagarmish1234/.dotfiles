{ pkgs, ... }:

{
  # Catppuccin: Global theme settings.
  # This uses the 'catppuccin/nix' flake to apply themed colors across many programs.
  catppuccin.flavor = "mocha";     # Dark, rich palette.
  catppuccin.accent = "lavender";  # Primary highlight color.
  catppuccin.enable = true;

  # GTK: GNOME ToolKit styling (Firefox, Nautilus, etc.).
  gtk = {
    enable = true;
    
    # Icons: Use 'candy-icons' for a vibrant, modern look.
    iconTheme = {
      # mkForce ensures these settings override any defaults from other modules.
      name = pkgs.lib.mkForce "candy-icons";
      package = pkgs.lib.mkForce pkgs.candy-icons;
    };

    # Theme: Catppuccin Mocha Lavender standard GTK theme.
    theme = {
      name = "catppuccin-mocha-lavender-standard";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        size = "standard";
        variant = "mocha";
      };
    };
  };

  # Cursor: Catppuccin Mocha Lavender pointer.
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.mochaLavender;
    name = "catppuccin-mocha-lavender-cursors";
    size = 24;
    gtk.enable = true; # Apply to GTK apps.
    x11.enable = true; # Apply to X11 apps.
  };

  # Qt: Styling for KDE/Qt-based applications.
  qt = {
    enable = true;
    platformTheme.name = "kvantum"; # Use Kvantum for better skinning.
    style.name = "kvantum";
  };

  # Catppuccin Overrides: Specifically enable/disable the theme for various programs.
  catppuccin.kvantum.enable = true;
  catppuccin.hyprland.enable = false;  # Handled manually in hyprland.nix for better control.
  catppuccin.hyprlock.enable = false;   # Handled manually in hyprlock.nix.
  catppuccin.starship.enable = true;
  catppuccin.fish.enable = true;
  catppuccin.bat.enable = true;
  catppuccin.fzf.enable = true;
  catppuccin.yazi.enable = true;
  catppuccin.ghostty.enable = true;
  catppuccin.vscode.profiles.default.enable = true;
  catppuccin.mpv.enable = true;
}
