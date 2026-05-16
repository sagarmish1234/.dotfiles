{ pkgs, lib, feature, ... }:
lib.mkIf feature.services.protonvpn {
  # ProtonVPN CLI for region switching
  environment.systemPackages = [ pkgs.protonvpn-cli ];
}
