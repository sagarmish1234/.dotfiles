{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "launch-wofi";
  runtimeInputs = [
    pkgs.wofi
    pkgs.procps
  ];
  text = ''
    if pgrep -x wofi >/dev/null; then
      pkill wofi
    else
      wofi
    fi
  '';
}
