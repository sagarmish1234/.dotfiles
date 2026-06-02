{ pkgs, ... }:

let
  # Wallpaper Source: Fetch a collection of Catppuccin Mocha wallpapers from GitHub.
  catppuccin-walls-src = pkgs.fetchFromGitHub {
    owner = "orangci";
    repo = "walls-catppuccin-mocha";
    rev = "7bfdf10d16ad3a689f9f0cf3a0930da3d1a245a8"; # Specific commit for reproducibility.
    fetchLFS = true; # Required because images are stored via Git Large File Storage.
    hash = "sha256-N+MZHSRcwOldS5Ai8B3YfKquKs9oeUW/GkV1iKM5+i8=";
  };

  # Post-Processing: Create a derivation that only contains the image files.
  # This avoids cluttering the wallpaper directory with READMEs, LICENSEs, or scripts.
  catppuccin-wallpapers = pkgs.runCommand "catppuccin-wallpapers" { } ''
    mkdir -p $out
    # Find all common image formats and copy them to the output folder.
    find ${catppuccin-walls-src} -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec cp {} $out/ \;
  '';
in
{
  # Deployment: Link the processed wallpapers to the user's Pictures directory.
  # Noctalia is configured to look for wallpapers in this path.
  home.file."Pictures/Wallpapers" = {
    source = catppuccin-wallpapers;
    recursive = false;
  };
}
