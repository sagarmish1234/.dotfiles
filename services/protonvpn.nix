{ pkgs, lib, feature, ... }:
lib.mkIf feature.services.protonvpn {
  # ProtonVPN for region switching (GUI package also provides CLI)
  environment.systemPackages = [ pkgs.protonvpn-gui ];
}
