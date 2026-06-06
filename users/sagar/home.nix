{ config, pkgs, ... }:

{
  # Imports: Modularly include user-specific program configurations.
  # This keeps the main home.nix clean.
  imports = [
    ./programs/noctalia.nix
    ./programs/wallpapers.nix
    ./programs/zoxide.nix
    ./programs/niri.nix
    ./programs/hypridle.nix
    ./programs/hyprlock.nix
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
    ./programs/zen.nix
  ];

  # Home Manager Settings
  home.username = "sagar";
  home.homeDirectory = "/home/sagar";

  # State Version: The Home Manager version used to initialize this setup.
  # Like system.stateVersion, only change if you know what you are doing.
  home.stateVersion = "26.05"; 

  # User Packages: Simple CLI tools and GUI apps that don't need complex configs.
  home.packages = with pkgs; [
    jq            # JSON processor.
    candy-icons   # Icon theme used by Noctalia and GTK.
    unzip         # Archive extractor.
    vscode        # Code editor.
    ffmpeg        # Multimedia framework.
    mpvpaper      # Tool to set video wallpapers via mpv.
    imagemagick   # Image manipulation tools.
    lazydocker    # Terminal UI for docker.
  ];

  # Ghostty: Modern, fast terminal emulator.
  programs.ghostty = {
    enable = true;
    settings = {
      # Shell: Force use of Fish shell for new windows.
      command = "/run/current-system/sw/bin/fish";

      # Typography
      font-family = "JetBrainsMono Nerd Font";
      font-style = "Regular";
      font-size = 12;

      # UI/UX
      window-padding-x = 16;
      window-padding-y = 16;
      window-padding-balance = true;
      window-padding-color = "background";
      confirm-close-surface = false; # Don't ask for confirmation on exit.
      resize-overlay = "never";      # Hide the '80x24' overlay when resizing.

      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;

      # Transparency: Enable slight transparency for a modern look.
      background-opacity = 0.75;
      window-decoration = false; # Borderless window (let Hyprland handle it).

      # Input
      mouse-scroll-multiplier = 0.95;
    };
  };

  # Plain Files: Use 'home.file' to symlink files from the flake to the home directory.
  home.file = {
    # Example: ".screenrc".source = dotfiles/screenrc;
  };

  # Environment Variables: Set variables for the user session.
  home.sessionVariables = {
    SHELL = "/run/current-system/sw/bin/fish";
    DOCKER_HOST = "unix:///run/user/1000/podman/podman.sock";
  };

  # Bash: Enable Bash and ensure it always execs into Fish for interactive use.
  programs.bash = {
    enable = true;
    initExtra = ''
      # If not already in fish and not running a single command, switch to fish.
      if [[ $ps_format != *"fish"* && -z "$BASH_EXECUTION_STRING" ]]; then
        exec /run/current-system/sw/bin/fish
      fi
    '';
  };

  # Fish Shell: Modern shell features.
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Silence the default welcome message.
    '';
    functions = {
      nvim = ''
        if test "$TERM" = "xterm-ghostty" -o -n "$GHOSTTY_BIN_DIR"
          if test -t 0 -a -t 1
            # Launch nvim in a new zero-padded Ghostty window using absolute path
            ghostty --window-padding-x=0 --window-padding-y=0 -e /etc/profiles/per-user/sagar/bin/nvim $argv
            return
          end
        end
        command nvim $argv
      '';
    };
  };

  # Starship: A cross-shell prompt that is fast and customizable.
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true; # Prompt clears on Enter for a cleaner history.
    settings = {
      add_newline = false;
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      # Directory Substitutions: Show nice icons for common folders.
      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = "󱑢 ";
        "Music" = "󰝚 ";
        "Pictures" = "󰉏 ";
      };
    };
  };

  # Let Home Manager manage its own installation.
  programs.home-manager.enable = true;
}
