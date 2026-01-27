{pkgs, ...}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
  };
  stylix.targets.gtk.enable = false;
  stylix.targets.noctalia-shell.enable = false;
}
