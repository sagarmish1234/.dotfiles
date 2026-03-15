{
  description = "Sagar's NixOS Flake";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
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
    import-tree.url = "github:vic/import-tree";

    astal.url = "github:aylur/astal";
    ags.url = "github:aylur/ags";
  };
  # Hello world
  outputs =
    {
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      feature = import ./feature.nix;
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = {
          inherit inputs feature system;
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = specialArgs;
              users.sagar.imports = [
                ./home.nix
                inputs.stylix.homeModules.stylix
                inputs.nvf.homeManagerModules.default
              ];
            };
          }
        ];
      };
    };
}
