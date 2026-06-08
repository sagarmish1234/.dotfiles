{
  # NixOS Dotfiles Configuration - Entry Point
  # This file defines the external dependencies (inputs) and the system configurations (outputs).
  description = "Modern Modular NixOS Flake";

  inputs = {
    # Updated to follow the stable 26.05 release branch
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";

    # Updated to track the matching stable 26.05 Home Manager release branch
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # sops-nix: Handles encrypted secrets (API keys, passwords) within the flake.
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # noctalia: The shell/desktop environment components.
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctaliaV5 = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Antigravity CLI
    antigravity-nix.url = "github:jacopone/antigravity-nix";

    # External themes and specialized browsers
    catppuccin.url = "github:catppuccin/nix";
    thorium.url = "github:Rishabh5321/custom-packages-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin-zen = {
      url = "github:catppuccin/zen-browser";
      flake = false; # This input is just raw files (CSS/JS), not a Nix flake itself.
    };

    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # 'inputs' here are the resolved packages defined above.
  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    catppuccin,
    thorium,
    zen-browser,
    catppuccin-zen,
    antigravity-nix,
    ...
  } @ inputs: {
    # Define a system configuration named 'nixos'.
    # Applied via: sudo nixos-rebuild switch --flake .#nixos
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # specialArgs allows us to pass flake inputs into individual modules.
      specialArgs = {inherit inputs;};
      modules = [
        ./hosts/nixos # Base host configuration.
        sops-nix.nixosModules.sops # Secrets management module.
        catppuccin.nixosModules.catppuccin # Global Catppuccin theme module.
        home-manager.nixosModules.home-manager # Home Manager system integration.
        {
          # Home Manager Settings
          home-manager.useGlobalPkgs = true; # Uses the system nixpkgs for user packages.
          home-manager.useUserPackages = true; # Installs user packages to /etc/profiles/per-user/sagar.
          home-manager.backupFileExtension = "backup"; # Automatically renames conflicting files to .backup.
          home-manager.extraSpecialArgs = {inherit inputs;};
          home-manager.users.sagar = {
            imports = [
              ./users/sagar/home.nix # User-specific Home Manager configuration.
              catppuccin.homeModules.catppuccin # Catppuccin theme for the user.
              inputs.nvf.homeManagerModules.default
              inputs.sops-nix.homeManagerModules.sops
            ];
          };
        }
      ];
    };
  };
}
