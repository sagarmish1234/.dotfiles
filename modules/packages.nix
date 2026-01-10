{ pkgs, inputs, ... }:
let
  launch-tui = import ../bin/launch-tui.nix { inherit pkgs; };
  launch-wofi = import ../bin/launch-wofi.nix { inherit pkgs; };
in
{
  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    libsForQt5.qtwayland
    nautilus
    fzf
    launch-tui
    launch-wofi
    jetbrains.idea
    vlc
    chromium
    gh
    firefox
  ];
}
