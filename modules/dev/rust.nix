{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.dev.rust {
  home.packages = with pkgs; [

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
