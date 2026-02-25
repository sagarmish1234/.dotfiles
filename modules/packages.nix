{
  pkgs,
  inputs,
  ...
}:
let
  launch-tui = import ../bin/launch-tui.nix { inherit pkgs; };
  launch-wofi = import ../bin/launch-wofi.nix { inherit pkgs; };
in
{
  programs = {
    # firefox.enable = true;
    yazi.enable = true;
    btop.enable = true;
  };
  # stylix.targets.firefox.profileNames = ["Sagar"];
  home.packages = with pkgs; [
    libsForQt5.qtwayland
    nautilus
    launch-tui
    launch-wofi
    jetbrains.idea
    chromium
    gh
    qbittorrent
    lshw
    spotify
    imv
    hyprshot
    quickshell
    qt6.qtdeclarative
    wl-clipboard
    wiremix
    typst
    localsend
    lazydocker
  ];
}
