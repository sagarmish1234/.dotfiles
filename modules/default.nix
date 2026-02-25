{ inputs, ... }:
{
  imports = [
    (inputs.import-tree ./shell)
    (inputs.import-tree ./browsers)
    (inputs.import-tree ./dev)
    ./editors
    ./git.nix
    ./ghostty.nix
    ./development.nix
    ./hyprland.nix
    ./waybar.nix
    ./awww.nix
    ./packages.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./swaync.nix
    ./mpv.nix
    ./rofi.nix
    ./webapps.nix
    ./noctalia.nix
    ./theme.nix
  ];
}
