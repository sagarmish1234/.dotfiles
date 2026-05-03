{ inputs, pkgs, ... }:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  programs.ags = {
    enable = true;

    # additional packages and executables to add to gjs's runtime
    extraPackages = with pkgs; [
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.battery
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.apps
      inputs.astal.packages.${pkgs.stdenv.hostPlatform.system}.io
      pkgs.gjs
    ];
  };
}
