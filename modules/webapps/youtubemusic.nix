{ pkgs, ... }:
{
  xdg.desktopEntries.youtube-music = {
    name = "Youtbe Music";
    exec = "${pkgs.chromium}/bin/chromium --app=https://music.youtube.com/"; # Or chromium
    icon = "youtube-music"; # Or specify a full path to an icon
    type = "Application";
    categories = [
      "Music"
    ];
  };
}
