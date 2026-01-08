{ pkgs, ... }:
pkgs.writeShellApplication {
  name = "launch-tui";
  runtimeInputs = [ pkgs.xdg-terminal-exec ];
  text = ''
    if [ -z "$1" ]; then
           echo "Usage: launch-tui <command> [args...]"
           exit 1
         fi

         exec ${pkgs.util-linux}/bin/setsid \
                xdg-terminal-exec \
                --app-id="sagar.nixos.$(basename "$1")" \
                -e "$1" "''${@:2}"
  '';
}
