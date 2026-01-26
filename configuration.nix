# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./services
  ];

  #Use Cachyos kernel
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wlogout
    glib
    gsettings-desktop-schemas
    polkit
    exfatprogs
  ];

  programs.nvf = {
    enable = true;

    # Your settings need to go into the settings attribute set
    # most settings are documented in the appendix
    settings = {
      vim.viAlias = false;
      vim.vimAlias = true;
      vim.dashboard.startify.enable = true;
      vim.statusline.lualine.enable = true;
      vim.tabline.nvimBufferline.enable = true;
      vim.filetree.neo-tree.enable = true;
      vim.telescope.enable = true;
      vim.binds.whichKey.enable = true;
      vim.autocomplete.nvim-cmp.enable = true;
      vim.snippets.luasnip.enable = true;
      vim.globals.mapleader = " ";
      vim.globals.maplocalleader = "\\";
      vim.keymaps = [
        {
          key = "<C-s>";
          mode = [
            "n"
            "i"
            "v"
          ]; # Normal, Insert, and Visual modes
          action = "<cmd>w<cr><esc>"; # Save and return to normal mode
          silent = true;
          desc = "Save file";
        }
        {
          key = "<C-h>";
          mode = "n";
          action = "<C-w>h";
          desc = "Go to Left Window";
        }
        {
          key = "<C-j>";
          mode = "n";
          action = "<C-w>j";
          desc = "Go to Lower Window";
        }
        {
          key = "<C-k>";
          mode = "n";
          action = "<C-w>k";
          desc = "Go to Upper Window";
        }
        {
          key = "<C-l>";
          mode = "n";
          action = "<C-w>l";
          desc = "Go to Right Window";
        }
      ];
      vim.theme = {
        enable = true;
        name = "catppuccin";
        style = "mocha"; # Options: storm, moon, night, day
      };
      vim.terminal = {
        toggleterm = {
          enable = true;
          lazygit = {
            enable = true;
            mappings.open = "<leader>gg";

          }; # Adds <leader>gg for lazygit, just like LazyVim
          direction = "horizontal"; # Options: "horizontal", "vertical", "float"
          mappings = {
            open = "<C-`>"; # Default toggle key
          };
          setupOpts = {
            winbar.enabled = false;
          };
        };
      };
      vim.ui = {
        noice.enable = true; # Replaces the command line and adds popup alerts
        borders.enable = true; # Adds rounded borders to popups/LSP windows
        illuminate.enable = true; # Highlights other uses of the word under cursor
      };
      vim.options = {
        autoindent = true;
        shiftwidth = 2;
        tabstop = 2;
        expandtab = true;
        shell = "${pkgs.fish}/bin/fish";
      };
      vim.visuals = {
        nvim-web-devicons.enable = true;
        indent-blankline.enable = true; # Adds the vertical indentation guides
      };
      vim.languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;
        # Replicate LazyVim language extras
        nix.enable = true;
        python.enable = true;
        rust.enable = true;
        ts.enable = true; # TypeScript
      };
    };
  };

  services.gvfs.enable = true;
  # programs.thunar = {
  #   enable = true;
  #   plugins = with pkgs.xfce; [
  #     thunar-archive-plugin
  #     thunar-volman
  #   ];
  # };

  system.stateVersion = "25.11";
  networking.hostName = "nixos"; # Define your hostname.
  xdg.terminal-exec = {
    enable = true;
    settings = {
      default = [ "ghostty.desktop" ];
    };
  };
  # Enable networking
  networking.networkmanager.enable = true;
  environment.variables.QT_QPA_PLATFORM = "wayland";

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;

      # Binary caches
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
      ];
    };

    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };
  # Bootloader (now configured in boot.nix module)
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest;
    # Kernel
    # kernelPackages = pkgs.linuxPackages_latest;
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  # services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  users.users.sagar = {
    isNormalUser = true;
    description = "Sagar Mishra";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };

  nixpkgs.config.allowUnfree = true;
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

}
