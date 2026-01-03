{ config, lib, pkgs, ... }:
{

    xdg.terminal-exec.enable = true;
    xdg.terminal-exec.settings.default = [ "ghostty.desktop" ];
      programs.ghostty = {
      enable = true;
      enableFishIntegration = true;
    };
}
