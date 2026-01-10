{ lib, feature, ... }:
lib.mkIf feature.shell.fish {

  programs.fish = {
    enable = true;
    shellInit = "
      set fish_greeting
    ";
  };

}
