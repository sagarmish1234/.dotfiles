{ pkgs, ... }:
{
  # Bat: A cat(1) clone with syntax highlighting and Git integration.
  programs = {
    bat = {
      enable = true;
      extraPackages = builtins.attrValues {
        inherit (pkgs.bat-extras)
          batman # Read system man pages using bat's syntax highlighting.
          ;
      };
    };

    # Shell Integration: Use bat/batman to replace standard commands.
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
}
