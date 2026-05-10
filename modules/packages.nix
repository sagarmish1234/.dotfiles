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
    btop.enable = true;
  };
  home.packages = with pkgs; [
    wlogout
    nvtopPackages.full
    launch-tui
    launch-wofi
    jetbrains.idea
    chromium
    gh
    qbittorrent
    spotify
    imv
    hyprshot
    wl-clipboard
    wiremix
    typst
    localsend
    lazydocker
    ani-cli
    psmisc
    nil
    simple-scan
    rclone
    dbeaver-bin
    nodePackages.mermaid-cli
    # aria2
    # transmission_4-qt6
  ];
  home.sessionPath = [ "$HOME/.cargo/bin" ];
}
