{
  pkgs,
  inputs,
  ...
}:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  home.packages = with unstable; [
    codecrafters-cli
  ];
}
