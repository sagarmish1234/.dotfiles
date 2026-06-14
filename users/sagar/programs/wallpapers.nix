{ pkgs, ... }:

let
  # Wallpaper Source: Fetch a collection of Tokyo Night wallpapers from GitHub.
  tokyonight-walls-src = pkgs.fetchFromGitHub {
    owner = "atraxsrc";
    repo = "tokyonight-wallpapers";
    rev = "main";
    hash = "sha256-GAkJ7l8vwJsyIe2Wl7r8Bw0cZ4RiJ44vaaaLCtIbzQY=";
  };

  # Post-Processing: Create a derivation that only contains the image files.
  # This avoids cluttering the wallpaper directory with READMEs, LICENSEs, or scripts.
  tokyonight-wallpapers = pkgs.runCommand "tokyonight-wallpapers" { } ''
    mkdir -p $out
    # Find all common image formats and copy them to the output folder.
    find ${tokyonight-walls-src} -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec cp {} $out/ \;
  '';
in
{
  # Deployment: Link the processed wallpapers to the user's Pictures directory.
  # Noctalia is configured to look for wallpapers in this path.
  home.file."Pictures/Wallpapers" = {
    source = tokyonight-wallpapers;
    recursive = false;
  };
}
