{
  pkgs,
  inputs,
  catppuccin,
  quickshell,
  ...
}:
let
  launch-tui = import ../bin/launch-tui.nix { inherit pkgs; };
  launch-wofi = import ../bin/launch-wofi.nix { inherit pkgs; };
in
{
  programs.firefox.enable = true;
  programs.eza.enable = true;
  programs.yazi.enable = true;
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
    qbittorrent
    adwaita-icon-theme
    lshw
    spotify
    vim
    imv
    hyprshot
    libnotify
    cliphist
    matugen
    cava
    evolution-data-server
    quickshell.packages.${pkgs.stdenv.hostPlatform.system}.quickshell
  ];
}
