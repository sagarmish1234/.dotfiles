{ pkgs, ... }:
{
  stylix = {
    enable = true;
    base16Scheme = {
      base00 = "#1a1b26"; # bg1
      base01 = "#3b4261"; # highlight
      base02 = "#3b4261"; # selection
      base03 = "#565f89"; # comment
      base04 = "#bb9af7"; # var
      base05 = "#c0caf5"; # base
      base06 = "#a9b1d6"; # cursor
      base07 = "#ffffff"; # head3-bg
      base08 = "#db4b4b"; # err
      base09 = "#ff9e64"; # const
      base0A = "#e0af68"; # war
      base0B = "#9ece6a"; # str
      base0C = "#73daca"; # suc
      base0D = "#7aa2f7"; # func
      base0E = "#bb9af7"; # keyword
      base0F = "#f1fa8c"; # type
    };
    polarity = "dark";
  };
  # stylix.targets.firefox.profileNames = ["Sagar"];
  stylix.targets.gtk.enable = false;
  stylix.targets.emacs.enable = false;
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
