{ pkgs, ... }:
{
  # Enable the Cloudflare WARP daemon
  services.cloudflare-warp.enable = true;

  # Add the CLI tool to system packages
  environment.systemPackages = [ pkgs.cloudflare-warp ];
}
