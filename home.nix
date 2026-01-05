{ config, pkgs,inputs, lib, ... }:
{
imports = [
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/vscode.nix
    ./modules/development.nix
    ./modules/walker.nix
    ./modules/starship.nix
    ./modules/fastfetch.nix
    ./modules/hyprland.nix
    ./modules/wofi.nix
    ./modules/waybar.nix
    ./modules/awww.nix
    ./modules/mako.nix
    # ./modules/hyprpaper.nix
    # Add other modules here
  ];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.sessionVariables = {
  EDITOR = "nvim";
};
programs.walker.enable = true;

programs.fish = {
  enable = true;
shellInit = "
      set fish_greeting
    ";
};
programs.chromium.enable = true;
home.sessionVariables = {
  # Firefox Wayland fixes
  MOZ_ENABLE_WAYLAND = "1";
  MOZ_DBUS_REMOTE = "1";
};
 # enable Hyprland
home.stateVersion = "25.11";
home.packages = with pkgs;[ 
  inputs.zen-browser.packages.${pkgs.system}.default
  libsForQt5.qtwayland

];

}
