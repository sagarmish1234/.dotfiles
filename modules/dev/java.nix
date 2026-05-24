{
  lib,
  feature,
  pkgs,
  unstable,
  ...
}:
lib.mkIf feature.dev.java {
  programs.java = {
    enable = true;
    package = unstable.openjdk25;
  };
  home.packages = with unstable; [
    # openjdk25
    # openjdk21
    maven
    gradle
    jdt-language-server
  ];
}
