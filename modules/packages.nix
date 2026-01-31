{
  pkgs,
  inputs,
  ...
}: let
  launch-tui = import ../bin/launch-tui.nix {inherit pkgs;};
  launch-wofi = import ../bin/launch-wofi.nix {inherit pkgs;};
in {
  programs.firefox.enable = true;
  programs.eza.enable = true;
  programs.yazi.enable = true;
  programs.btop.enable = true;
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
    lshw
    spotify
    vim
    imv
    hyprshot
    quickshell
    qt6.qtdeclarative
    wl-clipboard
    wiremix
    bluetui
    typst
  ];
}
