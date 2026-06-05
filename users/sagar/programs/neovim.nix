{ inputs, pkgs, ... }:

{
  programs.nvf = {
    enable = true;
    enableManpages = true;
    
    settings = {
      imports = [
        ./neovim/config
      ];
    };
  };
}
