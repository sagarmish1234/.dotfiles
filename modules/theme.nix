{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
  };
  stylix.targets.gtk.enable = false;
  stylix.targets.noctalia-shell.enable = false;
  gtk = {
    enable = true;
    theme = {
      package = pkgs.sweet;
      name = "Sweet-Dark";
    };
    iconTheme = {
      package = pkgs.candy-icons; # Replace with your chosen pack
      name = "candy-icons"; # The exact name used by the theme
    };
  };
}
