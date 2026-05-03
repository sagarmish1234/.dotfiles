{
  pkgs,
  config,
  lib,
  ...
}: {
  systemd.user.services.rclone-googledrive = {
    Unit = {
      Description = "rclone: Remote FUSE filesystem for Google Drive";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      Type = "simple";
      ExecStartPre = [
        "${pkgs.coreutils}/bin/mkdir -p ${config.home.homeDirectory}/GoogleDrive"
      ];
      ExecStart =
        "${pkgs.rclone}/bin/rclone mount sagar-google-drive: ${config.home.homeDirectory}/GoogleDrive "
        + "--config ${config.xdg.configHome}/rclone/rclone.conf "
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
        "PATH=${lib.makeBinPath [
          pkgs.fuse3
          pkgs.fuse
          pkgs.coreutils
          pkgs.rclone
        ]}:/run/wrappers/bin"
      ];
    };
  };
}
