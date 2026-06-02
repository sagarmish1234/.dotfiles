{ inputs, pkgs, ... }:

{
  # Packages: Use the Thorium browser (high-performance Chromium fork).
  home.packages = [
    inputs.thorium.packages.${pkgs.system}.thorium-avx2
  ];

  # Desktop Entries: Create standalone "apps" for frequently used websites.
  # This uses Thorium's '--app' mode to run them in a minimal window.
  xdg.desktopEntries = {
    yt-music = {
      name = "YouTube Music";
      genericName = "Music Player";
      exec = "thorium --app=https://music.youtube.com --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
      icon = "youtube-music";
      terminal = false;
      categories = [ "Audio" "Music" "Player" "AudioVideo" ];
      mimeType = [ "x-scheme-handler/https" "x-scheme-handler/http" ];
      settings = {
        StartupWMClass = "thorium-music.youtube.com__-Default";
      };
    };
    youtube = {
      name = "YouTube";
      genericName = "Video Player";
      exec = "thorium --app=https://youtube.com --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
      icon = "youtube";
      terminal = false;
      categories = [ "Video" "AudioVideo" "Network" "WebBrowser" ];
      mimeType = [ "x-scheme-handler/https" "x-scheme-handler/http" ];
      settings = {
        StartupWMClass = "thorium-youtube.com__-Default";
      };
    };
  };
}
