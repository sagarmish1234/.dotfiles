{ inputs, ... }:
{
  imports = [
    (inputs.import-tree ./shell)
    (inputs.import-tree ./browsers)
    (inputs.import-tree ./dev)
    (inputs.import-tree ./media)
    (inputs.import-tree ./webapps)
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
    ./rofi.nix
    ./noctalia.nix
    ./theme.nix
  ];
}
