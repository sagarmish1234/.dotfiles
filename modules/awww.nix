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
  home.file."Pictures/Wallpapers/Clearday.jpg".source = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/Clearday.jpg?raw=true";
    sha256 = "sha256-jAueWsy2a9tr3hguYktAh7d9EcSBeFOjDn4BZSDPqJQ=";
    # Run: nix-prefetch-url <url>
  };
  home.file."Pictures/Wallpapers/shaded_landscape.png".source = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/shaded_landscape.png?raw=true";
    sha256 = "sha256-EZmkN1HxI00/uS7PYU+/NN4sBzNNP901WJEET1G92to=";
  };
  home.file."Pictures/Wallpapers/Cloudsnight.jpg".source = pkgs.fetchurl {
    url = "https://github.com/zhichaoh/catppuccin-wallpapers/blob/main/landscapes/Cloudsnight.jpg?raw=true";
    sha256 = "sha256-jBv9iKBVQbgd1cmv+ubiJQH7qydRJZTShmwzEiJJcDA=";
    # Run: nix-prefetch-url <url>
  };

  home.file."Pictures/Wallpapers/void.png".source = pkgs.fetchurl {
    url = "https://github.com/atraxsrc/tokyonight-wallpapers/blob/main/void_original.png?raw=true";
    sha256 = "sha256-32LpCcZqf68QTMWtOFJkgg7Ev8Psi+cGc7bzvYHU9mM=";
    # Run: nix-prefetch-url <url>
  };

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
