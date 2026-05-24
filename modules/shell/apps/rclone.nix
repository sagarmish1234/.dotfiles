{
  pkgs,
  config,
  lib,
  ...
}: {
  sops.secrets.rclone_conf = {
    path = "${config.home.homeDirectory}/.config/rclone/rclone.conf";
    sopsFile = ../../../secrets/rclone.yaml;
  };

  systemd.user.services.rclone-googledrive = {
    Unit = {
      Description = "rclone: Remote FUSE filesystem for Google Drive";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Install = {
      # WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p ${config.home.homeDirectory}/GoogleDrive"
        "-/run/wrappers/bin/fusermount3 -u ${config.home.homeDirectory}/GoogleDrive"
      ];
      ExecStart =
        "${pkgs.rclone}/bin/rclone mount sagar-google-drive: ${config.home.homeDirectory}/GoogleDrive "
        + "--vfs-cache-mode full "
        + "--vfs-cache-max-age 24h "
        + "--vfs-cache-max-size 10G "
        + "--dir-cache-time 72h "
        + "--drive-chunk-size 64M "
        + "--allow-other "
        + "--allow-non-empty";
      ExecStop = "/run/wrappers/bin/fusermount3 -u ${config.home.homeDirectory}/GoogleDrive";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [
        "PATH=/run/wrappers/bin:${lib.makeBinPath [
          pkgs.fuse3
          pkgs.fuse
          pkgs.coreutils
          pkgs.rclone
        ]}"
      ];
    };
  };
}
