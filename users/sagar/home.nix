{
  config,
  pkgs,
  ...
}: {
  # Imports: Modularly include user-specific program configurations.
  # This keeps the main home.nix clean.
  imports = [
    # ./programs/noctalia.nix
    ./programs/noctaliaV5.nix
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
    ./programs/fuzzel.nix
    # ./programs/secrets.nix
    # ./programs/rclone.nix
    ./programs/ripgrep.nix
    ./programs/tealdeer.nix
    ./programs/webapps.nix
    ./programs/zen.nix
    ./programs/zed.nix
    ./programs/neovim.nix
    ./programs/atuin.nix
    ./programs/dolphin.nix
    ./programs/superseedr.nix
    ./programs/mcp.nix
  ];

  # Home Manager Settings
  home.username = "sagar";
  home.homeDirectory = "/home/sagar";

  # State Version: The Home Manager version used to initialize this setup.
  # Like system.stateVersion, only change if you know what you are doing.
  home.stateVersion = "26.11";

  # User Packages: Simple CLI tools and GUI apps that don't need complex configs.
  home.packages = with pkgs; [
    jq # JSON processor.
    candy-icons # Icon theme used by Noctalia and GTK.
    unzip # Archive extractor.
    vscode # Code editor.
    ffmpeg # Multimedia framework.
    mpvpaper # Tool to set video wallpapers via mpv.
    imagemagick # Image manipulation tools.
    lazydocker # Terminal UI for docker.
    xwayland-satellite
    wl-clipboard # Command-line copy/paste utilities for Wayland.
    gh
    adw-gtk3 # Adwaita theme engine for GTK 3 (styled dynamically by Noctalia)
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
      resize-overlay = "never"; # Hide the '80x24' overlay when resizing.

      # Cursor
      cursor-style = "block";
      cursor-style-blink = false;

      # Transparency: Enable slight transparency for a modern look.
      background = "0c0c12";
      background-opacity = 0.80;
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
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableTransience = true; # Prompt clears on Enter for a cleaner history.
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      add_newline = false;
      format = "[░▒▓](#a3aed2)[  ](bg:#a3aed2 fg:#090c0c)[](bg:#769ff0 fg:#a3aed2)$directory[](fg:#769ff0 bg:#394260)$git_branch$git_status[](fg:#394260 bg:#212736)$nodejs$bun$rust$golang$php[](fg:#212736 bg:#1d2230)$time[ ](fg:#1d2230)\n$character";

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        style = "fg:#e3e5e5 bg:#769ff0";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
        substitutions = {
          "Documents" = "󰈙 ";
          "Downloads" = " ";
          "Music" = " ";
          "Pictures" = " ";
        };
      };

      git_branch = {
        symbol = "";
        style = "bg:#394260";
        format = "[[ $symbol $branch ](fg:#769ff0 bg:#394260)]($style)";
      };

      git_status = {
        style = "bg:#394260";
        format = "[[($all_status$ahead_behind )](fg:#769ff0 bg:#394260)]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };

      bun = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };

      rust = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };

      golang = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };

      php = {
        symbol = "";
        style = "bg:#212736";
        format = "[[ $symbol ($version) ](fg:#769ff0 bg:#212736)]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:#1d2230";
        format = "[[  $time ](fg:#a0a9cb bg:#1d2230)]($style)";
      };
    };
  };

  # Git configuration managed by Home Manager
  programs.git = {
    enable = true;
    settings = {
      credential.helper = "store";
    };
  };

  # Let Home Manager manage its own installation.
  programs.home-manager.enable = true;
}
