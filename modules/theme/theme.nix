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
}
