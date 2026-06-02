{ pkgs, ... }:
let
  # Custom Astronaut Theme: Override the base sddm-astronaut package with specific settings.
  customAstronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      FullBlur = "false";
      PartialBlur = "false";
      Blur = "0";
      FontSize = "10";
      HaveFormBackground = "false";
    };
    embeddedTheme = "pixel_sakura"; # Use the 'pixel_sakura' sub-theme.
  };
in
{
  # Packages: Add the theme to the system environment.
  environment.systemPackages = [
    customAstronaut
  ];

  # SDDM Service: Configure the Simple Desktop Display Manager.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;          # Run the login screen itself in a Wayland session.
    package = pkgs.kdePackages.sddm; # Use the modern Qt6-based SDDM.
    theme = "${customAstronaut}/share/sddm/themes/sddm-astronaut-theme";
    
    # Extra Packages: Dependencies required for the theme to render correctly.
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
