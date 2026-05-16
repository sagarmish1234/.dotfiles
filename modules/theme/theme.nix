{ pkgs, lib, config, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    image = ../../assets/wallpapers/your-name-comet.png;

    cursor = {
      package = pkgs.catppuccin-cursors.mochaMauve;
      name = "catppuccin-mocha-mauve-cursors";
      size = 24;
    };
  };

  stylix.targets.firefox.profileNames = [ "default" ];
  stylix.targets.zen-browser.profileNames = [ "default" ];

  # Explicitly disable problematic Stylix targets (only valid ones)
  stylix.targets.gtk.enable = false;
  stylix.targets.vscode.enable = false;
  stylix.targets.hyprlock.enable = false;
  stylix.targets.hyprland.enable = false;
  stylix.targets.noctalia-shell.enable = false;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.catppuccin-gtk.override {
        accents = [ "mauve" ];
        variant = "mocha";
      };
      name = "catppuccin-mocha-mauve-standard";
    };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk";
  };
}
