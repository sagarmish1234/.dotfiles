{ pkgs, catppuccin, ... }:
{
  programs.btop.enable = true;
  catppuccin.btop = {
    enable = true;
    flavor = "mocha";
  };
  home.packages = with pkgs; [
    wiremix
    bluetui
    impala
  ];
}
