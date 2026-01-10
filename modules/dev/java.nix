{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.dev.java {

  home.packages = with pkgs; [
    jdk
    maven
    gradle
    jdt-language-server
  ];

}
