{
  pkgs,
  lib,
  feature,
  ...
}:
lib.mkIf feature.dev.go
{
  home.packages = with pkgs; [
    go
    gopls
    gotools
    go-tools
    golangci-lint
    delve
    gomodifytags
    gotests
    impl
  ];
}
