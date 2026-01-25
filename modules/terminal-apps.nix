{ pkgs, ... }:
{
  programs.btop.enable = true;
  home.packages = with pkgs; [
    wiremix
    bluetui
    impala
  ];
}
