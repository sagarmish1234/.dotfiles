{ lib, feature, ... }:
lib.mkIf feature.shell.fish {

  programs.fish = {
    enable = true;
    shellAliases = {
      btop = "btop --force-utf";
    };
    shellInit = "
      set fish_greeting
    ";
  };

}
