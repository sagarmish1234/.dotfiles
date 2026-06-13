{ config, pkgs, ... }:

{
  # Enable the Transmission daemon
  services.transmission = {
    enable = true;
    openRPCPort = true;     # Open firewall port 9091 for RPC/TUI clients
    openPeerPorts = true;   # Open incoming torrent traffic ports
    settings = {
      download-dir = "/var/lib/transmission/Downloads";
      incomplete-dir = "/var/lib/transmission/.incomplete";
      incomplete-dir-enabled = true;
      rpc-bind-address = "127.0.0.1"; # Secure: only allow local connections
      rpc-whitelist = "127.0.0.1";
      rpc-authentication-required = false; # No password needed for local TUI
      umask = 2; # Set umask to 002 so files are group-writable (rw-rw-r--)
    };
  };

  # Add user 'sagar' to the transmission group to allow access to downloaded files
  users.users.sagar.extraGroups = [ "transmission" ];

  # Install TUI clients (tremc)
  environment.systemPackages = with pkgs; [
    tremc
  ];
}
