{ config, pkgs, lib, ... }:
{
imports = [
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/vscode.nix
    ./modules/development.nix
    # Add other modules here
  ];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.sessionVariables = {
  EDITOR = "nvim";
};

 programs.starship = {
    enable = true;
    settings = {
      format = ''
        [╭─](bold green)$username[@](bold yellow)$hostname [in ](bold white)$directory$git_branch$git_status$cmd_duration
        [╰─](bold green)$character
      '';

      character = {
        success_symbol = lib.mkDefault "[➜](bold green)";
        error_symbol = lib.mkDefault "[➜](bold red)";
      };

      directory = {
        truncation_length = 3;
        truncate_to_repo = true;
        style = lib.mkDefault "bold cyan";
      };

      git_branch = {
        style = lib.mkDefault "bold purple";
        symbol = " ";
      };

      git_status = {
        style = lib.mkDefault "bold red";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };

      cmd_duration = {
        min_time = 500;
        format = " took [$duration](bold yellow)";
      };
    };
  };
programs.fish = {
  enable = true;
shellInit = "
      set fish_greeting
    ";
};
  home.stateVersion = "25.11";
}
