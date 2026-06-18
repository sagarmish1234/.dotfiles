{ pkgs, ... }:

let
  # Wallpaper Source: Fetch a collection of anime wallpapers from GitHub.
  anime-walls-src = pkgs.fetchFromGitHub {
    owner = "Samyc2002";
    repo = "Anime-Wallpapers";
    rev = "3dd63a2c339631fddbc2d9ba66b599cbd15552e0";
    hash = "sha256-4HenS5Ksjx4WAZOMRpydR7LJ/REBrDudt75Z3n6cxgo=";
  };

  # Post-Processing: Create a derivation that only contains the image files.
  anime-wallpapers = pkgs.runCommand "anime-wallpapers" { } ''
    mkdir -p $out
    # Find all common image formats recursively and copy them to the output folder.
    find ${anime-walls-src} -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec cp {} $out/ \;
  '';

  /*
  # Wallpaper Source: Fetch a collection of aesthetic wallpapers from GitHub.
  aesthetic-walls-src = pkgs.fetchFromGitHub {
    owner = "D3Ext";
    repo = "aesthetic-wallpapers";
    rev = "main";
    hash = "sha256-1b0J5Fn+nQ74rZNEHoghFW/iTbFq2hnjCafP4hAGeJ0=";
  };

  # Post-Processing: Create a derivation that only contains the image files.
  # This avoids cluttering the wallpaper directory with READMEs, LICENSEs, or scripts.
  aesthetic-wallpapers = pkgs.runCommand "aesthetic-wallpapers" { } ''
    mkdir -p $out
    # Find all common image formats recursively and copy them to the output folder.
    find ${aesthetic-walls-src} -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec cp {} $out/ \;
  '';
  */
in
{
  # Deployment: Link the processed wallpapers to the user's Pictures directory.
  # Noctalia is configured to look for wallpapers in this path.
  home.file."Pictures/Wallpapers" = {
    source = anime-wallpapers;
    recursive = false;
  };
}
