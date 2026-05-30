{ pkgs, ... }:
{

  programs = {
    bat = {
      enable = true;
      extraPackages = builtins.attrValues {
        inherit (pkgs.bat-extras)
          batman
          ;
      };
    };

    fish.functions = {
      man = {
        body = "batman $argv";
        wraps = "batman";
      };
      cat = {
        body = "bat $argv";
        wraps = "bat";
      };
      bat-rebuild = {
        body = "bat cache --build";
      };
    };

    bash.shellAliases = {
      cat = "bat";
      man = "batman";
      bat-rebuild = "bat cache --build";
    };
  };

  # Disable automatic cache generation to speed up activation
  home.activation.batCache = pkgs.lib.mkForce "";
}
