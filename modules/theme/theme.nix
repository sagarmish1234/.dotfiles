{ pkgs, lib, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
    polarity = "dark";
  };
  stylix.targets.firefox.profileNames = ["default"];
  stylix.targets.zen-browser.profileNames = ["default"];
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

  qt = {
    enable = true;
    platformTheme.name = lib.mkForce "gtk";
    style.name = lib.mkForce "adwaita-dark";
  };
}
