{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
  };
  # stylix.targets.firefox.profileNames = ["Sagar"];
  stylix.targets.emacs.enable = false;
  stylix.targets.noctalia-shell.enable = false;

  # Ensure Stylix does not override icon settings
  stylix.targets.gtk.enable = false;

  gtk = {
    enable = true;
    theme = {
      package = pkgs.tokyonight-gtk-theme;
      name = "Tokyonight-Dark";
    };
    iconTheme = {
      package = pkgs.candy-icons;
      name = "candy-icons";
    };
  };
}
