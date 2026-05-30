{ pkgs, ... }:

let
  catppuccin-walls-src = pkgs.fetchFromGitHub {
    owner = "orangci";
    repo = "walls-catppuccin-mocha";
    rev = "7bfdf10d16ad3a689f9f0cf3a0930da3d1a245a8";
    fetchLFS = true;
    hash = "sha256-N+MZHSRcwOldS5Ai8B3YfKquKs9oeUW/GkV1iKM5+i8=";
  };

  # Filter to only include image files and avoid cluttering with README, LICENSE, etc.
  catppuccin-wallpapers = pkgs.runCommand "catppuccin-wallpapers" { } ''
    mkdir -p $out
    find ${catppuccin-walls-src} -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec cp {} $out/ \;
  '';
in
{
  # Link the wallpapers to the directory used by Noctalia
  home.file."Pictures/Wallpapers" = {
    source = catppuccin-wallpapers;
    recursive = true;
  };
}
