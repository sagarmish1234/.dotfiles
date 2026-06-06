{ config, ... }: {
  sops = {
    age.keyFile = "/home/sagar/.config/sops/age/keys.txt";
  };

  sops.secrets.github_hosts = {
    path = "${config.home.homeDirectory}/.config/gh/hosts.yml";
    sopsFile = ../../../secrets/rclone.yaml;
  };

  sops.secrets.git_email = {
    sopsFile = ../../../secrets/rclone.yaml;
  };
}
