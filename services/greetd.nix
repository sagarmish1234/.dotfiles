{
  lib,
  feature,
  ...
}:
lib.mkIf feature.services.displayManager.greetd {
  services.displayManager.ly.enable = true;
}
