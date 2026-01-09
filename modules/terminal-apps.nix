{ pkgs, ... }:
{
  home.packages = with pkgs; [
    wiremix
    bluetui
    impala
    btop
  ];
}
