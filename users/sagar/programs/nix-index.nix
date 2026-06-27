{
  config,
  pkgs,
  ...
}: {
  # nix-index: Fast search tool for finding which Nix packages contain specific files/binaries.
  programs.nix-index = {
    enable = true;
  };

  # comma: Run commands from packages without installing them, powered by the nix-index prebuilt database.
  programs.nix-index-database.comma.enable = true;
}
