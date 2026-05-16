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
      url = "./config/noctalia-shell";
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
    catppuccin.url = "github:catppuccin/nix";
  };
  # Hello world
  outputs =
    {
      nixpkgs,
      home-manager,
      catppuccin,
      ...
    }@inputs:
    let
      feature = import ./feature.nix;
      system = "x86_64-linux";
      unstable = import inputs.nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      specialArgs = {
        inherit inputs feature unstable system;
      };
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        inherit specialArgs;
        modules = [
          { nixpkgs.hostPlatform = "x86_64-linux"; }
          ./configuration.nix
          home-manager.nixosModules.default
          # catppuccin.nixosModules.catppuccin
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
