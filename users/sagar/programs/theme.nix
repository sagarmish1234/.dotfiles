{ pkgs, ... }:

{
  # GTK: GNOME ToolKit styling (Firefox, Nautilus, etc.).
  gtk = {
    enable = true;
    
    # Icons: Use 'candy-icons' for a vibrant, modern look.
    iconTheme = {
      # mkForce ensures these settings override any defaults from other modules.
      name = pkgs.lib.mkForce "candy-icons";
      package = pkgs.lib.mkForce pkgs.candy-icons;
    };
  };

  # Stylix: Declare Zen Browser profile names for automatic theming
  stylix.targets.zen-browser.profileNames = [ "sagar" ];

}
