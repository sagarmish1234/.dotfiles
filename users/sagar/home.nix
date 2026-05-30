{ config, pkgs, ... }:

{
  imports = [
    ./programs/noctalia.nix
    ./programs/zoxide.nix
    ./programs/hyprland.nix
    ./programs/wayland.nix
    ./programs/theme.nix
    ./programs/mpv.nix
    ./programs/yazi.nix
    ./programs/bat.nix
    ./programs/eza.nix
    ./programs/fastfetch.nix
    ./programs/fzf.nix
    # ./programs/rclone.nix
    ./programs/ripgrep.nix
    ./programs/tealdeer.nix
    ./programs/webapps.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should manage.
  home.username = "sagar";
  home.homeDirectory = "/home/sagar";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  home.stateVersion = "26.05"; 

  # The home.packages option allows you to install User packages directly into your environment.
  home.packages = with pkgs; [
    jq
    candy-icons
    unzip
    vscode 
  ];

  programs.ghostty = {
    enable = true;
    settings = {
      command = "/run/current-system/sw/bin/fish";

      # Font settings
      font-family = "JetBrainsMono Nerd Font";
      font-style = "Regular";
      font-size = 12;

      # Window styling
      window-padding-x = 16;
      window-padding-y = 16;
      window-padding-balance = true;
      window-padding-color = "background";
      confirm-close-surface = false;
      resize-overlay = "never";

      # Cursor styling
      cursor-style = "block";
      cursor-style-blink = false;

      # Keyboard bindings
      keybind = [
        "shift+insert=paste_from_clipboard"
        "control+insert=copy_to_clipboard"
        "super+control+shift+alt+arrow_down=resize_split:down,100"
        "super+control+shift+alt+arrow_up=resize_split:up,100"
        "super+control+shift+alt+arrow_left=resize_split:left,100"
        "super+control+shift+alt+arrow_right=resize_split:right,100"
      ];

      # Transparency
      background-opacity = 0.75;
      window-decoration = false;

      # Mouse scrolling
      mouse-scroll-multiplier = 0.95;
    };
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  # You can also manage environment variables. 
  home.sessionVariables = {
    SHELL = "/run/current-system/sw/bin/fish";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [[ $ps_format != *"fish"* && -z "$BASH_EXECUTION_STRING" ]]; then
        exec /run/current-system/sw/bin/fish
      fi
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true;
    # Add some nice symbols and settings
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      # Nerd font symbols preset-like settings
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = "󱑢 ";
        "Music" = "󰝚 ";
        "Pictures" = "󰉏 ";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
