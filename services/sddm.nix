{ pkgs, ... }:
let
  # Override to apply your "Chili" look
  customAstronaut = pkgs.sddm-astronaut.override {
    themeConfig = {
      # Disable blur to show the animation clearly
      FullBlur = "false";
      PartialBlur = "false";
      Blur = "0";
      FontSize = "8";
      # Optional: Adjust the form background if text is hard to read
      # This puts a slight dark tint behind just the login box
      HaveFormBackground = "false";
      FormBackgroundAlpha = "0.2";
    };
    embeddedTheme = "pixel_sakura";
  };
in
{
  # CRITICAL: This puts the theme files into /run/current-system/sw/share/sddm/themes/
  environment.systemPackages = [
    customAstronaut
    pkgs.kdePackages.qtmultimedia # Astronaut requires this to load Main.qml properly
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm; # Qt6 version
    theme = "sddm-astronaut-theme";
    extraPackages = [ customAstronaut ];
  };
}
