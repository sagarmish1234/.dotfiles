{ lib, feature, ... }:
lib.mkIf feature.services.displayManager.sdm {
  services.displayManager.gdm.enable = true;
}
