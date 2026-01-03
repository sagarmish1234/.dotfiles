{
  description = "Sagar's NixOS Flake";

  inputs = {
    # NixOS official package sources
    nixpkgs.url = "github:NixOS/nixpkgs";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {  nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
          inherit inputs;
        };
      modules = [
        ./configuration.nix
         home-manager.nixosModules.default
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.sagar = ./home.nix; # replace <USERNAME> with your actual username
            };
          }
      ];
    };
  };
}
