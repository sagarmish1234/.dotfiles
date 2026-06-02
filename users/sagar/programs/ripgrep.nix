{
  # Ripgrep: A line-oriented search tool that recursively searches your current directory for a regex pattern.
  programs.ripgrep = {
    enable = true;
    arguments = [
      "--max-columns=150"         # Don't print extremely long lines.
      "--max-columns-preview"     # Show a preview of long lines.
      "--hidden"                  # Search hidden files by default.
      "--smart-case"              # Case-insensitive if the pattern is all lowercase.
    ];
  };
}
