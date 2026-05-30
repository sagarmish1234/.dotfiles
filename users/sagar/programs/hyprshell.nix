{ inputs, pkgs, ... }:

{
  imports = [
    inputs.hyprshell.homeModules.default
  ];

  programs.hyprshell = {
    enable = true;
    settings = {
	windows = {
	    enable = true;
	    switch.enable = true;
	};	
   }; 
    # Add any specific hyprshell settings here if needed
  };
}
