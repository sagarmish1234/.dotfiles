{ config, pkgs, ... }:
{
imports = [
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/vscode.nix
    # ./modules/development.nix
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

programs.neovim = {
  enable = true;
  vimAlias = true;
  vimdiffAlias = true;
  withNodeJs = true;
};
programs.starship = {
    enable = true;
    enableFishIntegration = true;

    # Optional: Configure starship settings using the settings attribute
    settings = {
      # Inserts a blank line between shell prompts
      add_newline = true;
      # Customize the prompt character
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[✗](bold red)";
      };
      # Customize specific modules, e.g., directory
      directory = {
        truncation_length = 3;
      };
      # Example of disabling a module
      package.disabled = true;
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
