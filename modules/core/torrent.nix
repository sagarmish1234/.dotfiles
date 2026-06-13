{ config, pkgs, inputs, ... }:

let
  superseedr-latest = pkgs.stdenv.mkDerivation rec {
    pname = "superseedr";
    version = "1.0.9";

    src = pkgs.fetchurl {
      url = "https://github.com/Jagalite/superseedr/releases/download/v${version}/superseedr_v${version}_amd64.deb";
      sha256 = "06vikv5r3k42dhq6d9n69r2i95dmf1gghmcymp0bg6kbpsk0d06a";
    };

    nativeBuildInputs = [ pkgs.autoPatchelfHook pkgs.dpkg ];

    buildInputs = [ pkgs.openssl pkgs.gcc.cc.lib ];

    unpackPhase = "dpkg-deb -x $src .";

    installPhase = ''
      mkdir -p $out/bin
      cp usr/bin/superseedr $out/bin/
    '';
  };
in
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

  # Install TUI clients (tremc, superseedr)
  environment.systemPackages = with pkgs; [
    tremc
    superseedr-latest
  ];
}
