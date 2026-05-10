{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = false;
    configDir = ../config/ags;

    # additional packages and executables to add to gjs's runtime
    extraPackages = with pkgs; [
      inputs.ags.packages.${pkgs.system}.astal3
      inputs.ags.packages.${pkgs.system}.io
      inputs.ags.packages.${pkgs.system}.battery
      inputs.ags.packages.${pkgs.system}.apps
      inputs.ags.packages.${pkgs.system}.network
      inputs.ags.packages.${pkgs.system}.mpris
      inputs.ags.packages.${pkgs.system}.tray
      inputs.ags.packages.${pkgs.system}.notifd
      inputs.ags.packages.${pkgs.system}.hyprland
      inputs.ags.packages.${pkgs.system}.wireplumber
      pkgs.gjs
      pkgs.libadwaita
    ];
  };

  # Symlink config to ~/.config/ags
  xdg.configFile."ags".source = ../config/ags;
}
