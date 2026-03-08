{
  lib,
  feature,
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
lib.mkIf feature.dev.rust {
  home.packages = with unstable; [

    rustc
    cargo
    rustfmt
    rust-analyzer
    clippy
    cargo-watch
    cargo-edit
    cargo-audit
    bacon

  ];
}
