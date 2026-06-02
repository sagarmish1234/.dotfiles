{ pkgs, ... }:
{
  # MPV: A free, open-source, and cross-platform media player.
  programs.mpv = {
    enable = true;
    
    # Keybindings: Define custom controls.
    bindings = {
      "UP" = "add volume 5";   # Increase volume by 5%.
      "DOWN" = "add volume -5"; # Decrease volume by 5%.
    };

    # Custom Package: Override mpv to include specialized scripts and Wayland support.
    package = pkgs.mpv.override {
      scripts = with pkgs.mpvScripts; [
        sponsorblock       # Skip sponsored segments in YouTube videos.
        modernz            # A more modern, minimal UI.
        autosub            # Automatically find and download subtitles.
        quality-menu       # GUI for choosing video quality (e.g., for YouTube).
        autosubsync-mpv    # Sync subtitles automatically.
        mpv-notify-send    # Show desktop notifications for track changes.
        thumbfast          # Fast, high-quality thumbnails on the seek bar.
        mpv-playlistmanager # Manage and search the current playlist.
        memo               # Save and restore playback position for videos.
      ];

      # Wayland: Ensure the base mpv build has Wayland support enabled.
      mpv-unwrapped = pkgs.mpv-unwrapped.override {
        waylandSupport = true;
      };
    };

    # Configuration: Internal mpv settings.
    config = {
      profile = "high-quality";            # Best possible video quality by default.
      ytdl-format = "bestvideo+bestaudio"; # Ensure best quality when playing URLs.
      cache-default = 4000000;             # 4MB default cache.
      target-colorspace-hint = "no";
    };
  };
}
