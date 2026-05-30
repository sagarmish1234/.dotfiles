{ pkgs, ... }:
let
  # Custom astronaut theme with pixel_sakura embedded theme and custom config
  customAstronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      FullBlur = "false";
      PartialBlur = "false";
      Blur = "0";
      FontSize = "10";
      HaveFormBackground = "false";
    };
    embeddedTheme = "pixel_sakura";
  };
in
{
  environment.systemPackages = [
    customAstronaut
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm; # Qt6 version
    theme = "${customAstronaut}/share/sddm/themes/sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      customAstronaut
      qtmultimedia
      qtsvg
      qtvirtualkeyboard
      qt5compat
      qtquickeffectmaker
      qtwayland
      qtimageformats
    ];
  };
}
