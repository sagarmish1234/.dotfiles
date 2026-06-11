{ pkgs, ... }:

{
  # Catppuccin: Global theme settings.
  # This uses the 'catppuccin/nix' flake to apply themed colors across many programs.
  catppuccin.flavor = "mocha";     # Dark, rich palette.
  catppuccin.accent = "lavender";  # Primary highlight color.
  catppuccin.enable = false;       # Disabled to migrate to Eldritch

  # GTK: GNOME ToolKit styling (Firefox, Nautilus, etc.).
  gtk = {
    enable = true;
    
    # Icons: Use 'candy-icons' for a vibrant, modern look.
    iconTheme = {
      # mkForce ensures these settings override any defaults from other modules.
      name = pkgs.lib.mkForce "candy-icons";
      package = pkgs.lib.mkForce pkgs.candy-icons;
    };

    # Theme: Use adw-gtk3-dark which will be styled dynamically by Noctalia templates.
    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
  };

  # Cursor: Standard premium Adwaita cursor.
  home.pointerCursor = {
    package = pkgs.adwaita-icon-theme;
    name = "Adwaita";
    size = 24;
    gtk.enable = true; # Apply to GTK apps.
    x11.enable = true; # Apply to X11 apps.
  };

  # Qt: Styling for KDE/Qt-based applications (integrated with Noctalia qt5ct templates).
  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "adwaita-dark";
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
  catppuccin.fuzzel.enable = true;
}
