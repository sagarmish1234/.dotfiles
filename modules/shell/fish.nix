{ lib, feature, ... }:
lib.mkIf feature.shell.fish {

  programs.fish = {
    enable = true;
    shellAliases = {
      btop = "btop --force-utf";
      nrs = "sudo nixos-rebuild switch --flake .";
    };
    shellInit = "
      set fish_greeting
    ";
  };

}
