{ pkgs, config, ... }:
{
  # Create the mount point directory
  home.file."GoogleDrive/.keep".text = "";

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
      # Ensure the directory exists before mounting and wait for network
      ExecStartPre = [
        "/run/current-system/sw/bin/mkdir -p ${config.home.homeDirectory}/GoogleDrive"
        "${pkgs.coreutils}/bin/sleep 5"
      ];
      ExecStart = "${pkgs.rclone}/bin/rclone mount sagar-google-drive: ${config.home.homeDirectory}/GoogleDrive " +
                 "--config ${config.xdg.configHome}/rclone/rclone.conf " +
                 "--vfs-cache-mode full " +
                 "--vfs-cache-max-age 24h " +
                 "--vfs-cache-max-size 10G " +
                 "--dir-cache-time 72h " +
                 "--drive-chunk-size 64M " +
                 "--allow-other";
      ExecStop = "fusermount -u ${config.home.homeDirectory}/GoogleDrive";
      Restart = "on-failure";
      RestartSec = "10s";
      Environment = [ "PATH=/run/current-system/sw/bin:/run/wrappers/bin:/home/sagar/.nix-profile/bin:/nix/var/nix/profiles/default/bin:/usr/bin:/bin" ];
    };
  };
}
