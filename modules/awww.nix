{
  pkgs,
  inputs,
  ...
}:
let
  wallpaper_config = import ../config/wallpaper/config.nix;
  launch-wallpaper = import ../bin/launch-wallpaper.nix {
    inherit pkgs;
    inherit wallpaper_config;
    inherit inputs;
  };

  wallpaper-switcher = import ../bin/wallpaper-switcher.nix {
    inherit pkgs;
    inherit wallpaper_config;
    inherit inputs;
  };
in
{
  # Install awww
  home.packages = [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    launch-wallpaper
    wallpaper-switcher
  ];

  # Ensure wallpaper directory exists
  home.file."Pictures/Wallpapers/.keep".text = "";

  # Optional: Download a Catppuccin Mocha wallpaper
  home.file."Pictures/Wallpapers/Clearday.jpg".source = ../assets/wallpapers/Clearday.jpg;
  home.file."Pictures/Wallpapers/shaded_landscape.png".source =
    ../assets/wallpapers/shaded_landscape.png;
  home.file."Pictures/Wallpapers/Cloudsnight.jpg".source = ../assets/wallpapers/Cloudsnight.jpg;
  home.file."Pictures/Wallpapers/void.png".source = ../assets/wallpapers/void.png;
  home.file."Pictures/Wallpapers/anime-paper-1.png".source = ../assets/wallpapers/anime-paper-1.png;
  home.file."Pictures/Wallpapers/anime-paper-2.jpg".source = ../assets/wallpapers/anime-paper-2.jpg;
  # Hyprland configuration
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      # Start awww daemon on Hyprland startup
      exec-once = [
        "${launch-wallpaper}/bin/launch-wallpaper"
      ];

      bind = [
        # Optional: Add wallpaper switcher binding
        "SUPER SHIFT, W, exec, ${wallpaper-switcher}/bin/wallpaper-switcher"
      ];
    };
  };

}
