{ pkgs, lib, feature, ... }:
lib.mkIf feature.services.vpn {
  # Enable the Cloudflare WARP daemon
  services.cloudflare-warp.enable = true;

  # Add the CLI tool to system packages
  environment.systemPackages = [ pkgs.cloudflare-warp ];
}
