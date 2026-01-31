{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.dev.java {
  programs.java = {
    enable = true;
    package = pkgs.openjdk25;
  };
  home.packages = with pkgs; [
    # openjdk25
    # openjdk21
    maven
    gradle
  ];
}
