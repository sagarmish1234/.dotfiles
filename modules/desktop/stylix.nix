{ pkgs, inputs, ... }:

{
  stylix = {
    enable = true;
    image = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/D3Ext/aesthetic-wallpapers/main/images/anime_cafe_tokyonight.png";
      sha256 = "sha256-FYVR4RGtNQtqqUFiZb2A0ZBQ/2quQ+YXPwL88pQcLfM=";
    };
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";

    cursor = {
      package = pkgs.adwaita-icon-theme;
      name = "Adwaita";
      size = 24;
    };

    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      serif = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      
      sizes = {
        applications = 12;
        terminal = 12;
        desktop = 11;
        popups = 11;
      };
    };

    # Automatically enable theme across all supported targets
    autoEnable = true;
  };
}
