{
  lib,
  feature,
  pkgs,
  inputs,
  unstable,
  ...
}:

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
