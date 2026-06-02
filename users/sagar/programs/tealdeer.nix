{
  # Tealdeer: A fast implementation of 'tldr' (simplified, community-driven man pages).
  programs.tealdeer = {
    enable = true;
    settings.updates.auto_update = true; # Automatically update the cache when using the tool.
  };
}
