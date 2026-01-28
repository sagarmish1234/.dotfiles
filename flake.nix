{
  description = "Sagar's NixOS Flake";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    awww.url = "git+https://codeberg.org/LGFae/awww";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    stylix = {
      url = "github:nix-community/stylix/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvf.url = "github:notashelf/nvf";
    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    feature = import ./feature.nix;
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit inputs;
        inherit feature;
      };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.default
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            backupFileExtension = "bak";
            users.sagar = {
              imports = [
                ./home.nix
                inputs.stylix.homeModules.stylix
                inputs.nvf.homeManagerModules.default
                inputs.noctalia.homeModules.default
              ];
            };
          };
          home-manager.extraSpecialArgs = {
            inherit inputs;
            inherit feature;
            system = "x86_64-linux";
          };
        }
      ];
    };
  };
}
