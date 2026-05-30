{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.thorium.packages.${pkgs.system}.thorium-avx2
  ];

  # Create a desktop entry for YouTube Music using Thorium
  xdg.desktopEntries = {
    yt-music = {
      name = "YouTube Music";
      genericName = "Music Player";
      exec = "thorium --app=https://music.youtube.com --ozone-platform-hint=auto --enable-features=WaylandWindowDecorations";
      icon = "youtube-music"; # Standard icon name, should work if theme has it
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
