{
  pkgs,
  lib,
  feature,
  unstable,
  ...
}:
lib.mkIf feature.dev.go
{
  home.packages = with unstable; [
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
