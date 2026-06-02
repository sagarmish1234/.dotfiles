{
  # NixOS Dotfiles Configuration - Entry Point
  # This file defines the external dependencies (inputs) and the system configurations (outputs).
  description = "Modern Modular NixOS Flake";

  inputs = {
    # nixpkgs: The primary repository for Nix packages and modules.
    # We use 'nixos-unstable' for the latest software and hardware support.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    # home-manager: Manages user-specific configuration and dotfiles.
    # It integrates with NixOS via a module, allowing a single rebuild command.
    home-manager = {
      url = "github:nix-community/home-manager";
      # 'inputs.nixpkgs.follows' ensures Home Manager uses the same nixpkgs version as the main flake.
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

    # External themes and specialized browsers
    catppuccin.url = "github:catppuccin/nix";
    thorium.url = "github:Rishabh5321/custom-packages-flake";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    catppuccin-zen = {
      url = "github:catppuccin/zen-browser";
      flake = false; # This input is just raw files (CSS/JS), not a Nix flake itself.
    };
  };

  # 'inputs' here are the resolved packages defined above.
  outputs = { self, nixpkgs, home-manager, sops-nix, catppuccin, thorium, zen-browser, catppuccin-zen, ... }@inputs: {
    # Define a system configuration named 'nixos'.
    # Applied via: sudo nixos-rebuild switch --flake .#nixos
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # specialArgs allows us to pass flake inputs into individual modules.
      specialArgs = { inherit inputs; };
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
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.sagar = {
            imports = [
              ./users/sagar/home.nix # User-specific Home Manager configuration.
              catppuccin.homeModules.catppuccin # Catppuccin theme for the user.
            ];
          };
        }
      ];
    };
  };
}
