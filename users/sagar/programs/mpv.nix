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

      # Hardware Video Acceleration (NVIDIA NVDEC/VA-API)
      hwdec = "auto-safe";                 # Automatically use hardware decoding if safe
      vo = "gpu";                          # High-quality GPU video output

      # OSD Styling (Tokyo Night)
      osd-color = "#c0caf5";               # Foreground text (Soft lavender-blue)
      osd-border-color = "#1a1b26";        # Border outline (Dark background)
      osd-back-color = "#11121d";          # Backdrop color (Deep dark variant)
      osd-border-size = 2;                 # Clean outline border size
    };

    # Script Options: Configure modernz OSC with Tokyo Night theme colors.
    scriptOpts = {
      modernz = {
        # Layout & Colors
        osc_color = "#1a1b26";             # Main background (Tokyo Night dark)
        window_title_color = "#c0caf5";    # Title text
        window_controls_color = "#c0caf5"; # Window buttons
        title_color = "#c0caf5";
        time_color = "#c0caf5";
        chapter_title_color = "#c0caf5";
        cache_info_color = "#c0caf5";

        # Seekbar and handles
        seekbarfg_color = "#7aa2f7";            # Progress (Tokyo Night Blue)
        seekbarbg_color = "#24283b";            # Remaining (Surface Variant)
        seek_handle_color = "#7aa2f7";          # Seek handle (Tokyo Night Blue)
        seek_handle_border_color = "#1a1b26";   # Inner handle border (Background)
        seekbar_cache_color = "#2e3c64";        # Cache color (Darker blue-gray)

        # Buttons
        side_buttons_color = "#c0caf5";
        middle_buttons_color = "#c0caf5";
        playpause_color = "#7aa2f7";            # Play/pause button accent
        held_element_color = "#2e3c64";         # Clicked/held element color
        hover_effect_color = "#bb9af7";         # Hover accent (Tokyo Night Purple)

        # Markers/Nibbles
        nibble_color = "#7aa2f7";               # Chapter markers
        nibble_current_color = "#bb9af7";       # Active chapter marker
      };
    };
  };

  # Set MPV as the default media player for common audio/video file formats
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = [ "mpv.desktop" ];
      "video/mkv" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/x-flv" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "video/x-msvideo" = [ "mpv.desktop" ];
      "video/x-ms-wmv" = [ "mpv.desktop" ];
      "video/ogg" = [ "mpv.desktop" ];
      "audio/mp3" = [ "mpv.desktop" ];
      "audio/x-wav" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/flac" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/aac" = [ "mpv.desktop" ];
      "audio/m4a" = [ "mpv.desktop" ];
      "audio/opus" = [ "mpv.desktop" ];
      "audio/webm" = [ "mpv.desktop" ];
    };
  };
}
