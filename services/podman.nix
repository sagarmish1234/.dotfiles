{ lib, feature, ... }:
lib.mkIf feature.services.virtualization.podman {
  virtualisation.podman = {
    enable = true;
    # Create a `docker` alias for podman
    dockerCompat = true;

    # Required for containers under podman-compose to talk to each other
    defaultNetwork.settings.dns_enabled = true;
  };
}
