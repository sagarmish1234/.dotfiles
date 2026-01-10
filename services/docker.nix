{ lib, feature, ... }:
lib.mkIf feature.services.virtualization.docker {
  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    daemon.settings = {
      features = {
        buildkit = true;
      };
      registry-mirrors = [ "https://mirror.gcr.io" ];
    };

    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };
}
