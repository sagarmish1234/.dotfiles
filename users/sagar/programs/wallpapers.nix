{ pkgs, ... }:

let
  # Wallpaper Source: Fetch a collection of wallpapers from GitHub.
  walls-src = pkgs.fetchFromGitHub {
    owner = "orangci";
    repo = "walls";
    rev = "f61033f92cc24c60aebd306e113eb2aacd498c0f";
    hash = "sha256-2/dZGA5IoYANTUlR0I/GUtO8GeOlzAHouyjtKuVvcl4=";
  };

  # Post-Processing: Create a derivation that only contains the image files.
  wallpapers = pkgs.runCommand "wallpapers" { } ''
    mkdir -p $out
    # Find all common image formats recursively and copy them to the output folder.
    find ${walls-src} -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" -o -iname "*.gif" \) -exec cp {} $out/ \;
  '';
in
{
  # Deployment: Link the processed wallpapers to the user's Pictures directory.
  # Noctalia is configured to look for wallpapers in this path.
  home.file."Pictures/Wallpapers" = {
    source = wallpapers;
    recursive = false;
  };
}
