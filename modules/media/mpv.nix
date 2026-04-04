{ pkgs, ... }:
{
  programs.mpv = {
    enable = true;
    bindings = {
      "UP" = "add volume 5"; # Increase volume by 5%
      "DOWN" = "add volume -5"; # Decrease volume by 5%
    };
    package = (
      pkgs.mpv-unwrapped.wrapper {
        scripts = with pkgs.mpvScripts; [
          # uosc
          sponsorblock
          modernz
          autosub
          quality-menu
          autosubsync-mpv
          mpv-notify-send
          thumbfast
          mpv-playlistmanager
          memo
        ];

        mpv = pkgs.mpv-unwrapped.override {
          waylandSupport = true;
        };
      }
    );

    config = {
      profile = "high-quality";
      ytdl-format = "bestvideo+bestaudio";
      cache-default = 4000000;
      target-colorspace-hint = "no";
    };
  };
}
