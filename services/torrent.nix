{ pkgs, ... }:
{
  services.transmission = {
    enable = true;
    user = "sagar";
    group = "users";
    package = pkgs.transmission_4;
    settings = {
      download-dir = "/home/sagar/Downloads/Torrents";
      incomplete-dir = "/home/sagar/Downloads/Torrents/.incomplete";
      incomplete-dir-enabled = true;
      rpc-bind-address = "127.0.0.1";
      rpc-whitelist = "127.0.0.1";
      rpc-port = 9091;
      rpc-authentication-required = false;
      peer-port = 51413;
      ratio-limit-enabled = true;
      ratio-limit = 2;
    };
  };

  networking.firewall = {
    allowedTCPPorts = [ 51413 ];
    allowedUDPPorts = [ 51413 ];
  };
}
