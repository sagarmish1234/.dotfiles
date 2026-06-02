{ ... }:
{
  # Eza: A modern, feature-rich replacement for 'ls'.
  programs.eza = {
    enable = true;
    git = true;        # Show git status for files.
    icons = "auto";    # Automatically enable Nerd Font icons.
    extraOptions = [
      "--group-directories-first" # Folders first, then files.
      "--header"                  # Show column headers.
      "--smart-group"             # Use different colors for different user groups.
      "--hyperlink"               # Make file paths clickable in supported terminals.
    ];
  };
}
