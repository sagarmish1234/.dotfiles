{ config, pkgs, ... }:

{
  # Atuin: Shell history search database and sync.
  # Replaces the default Ctrl+R shell history with a sqlite-backed fuzzy finder.
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;

    settings = {
      auto_sync = false;          # Disable sync by default (requires registration/login).
      search_mode = "fuzzy";      # Perform fuzzy search.
      filter_mode = "global";     # Search history from all sessions by default.
      style = "compact";          # Render a cleaner, less verbose UI.
      inline_height = 15;         # Limits height so it does not fill the entire terminal window.
      show_preview = true;        # Display extra metadata (exit code, runtime, time).
      show_tabs = true;           # Show search scope tabs (Global/Directory/Session).
    };
  };
}
