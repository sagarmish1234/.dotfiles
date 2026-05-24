{
  lib,
  feature,
  pkgs,
  unstable,
  ...
}:
lib.mkIf feature.editor.zed {
  # ... other configurations
  home.packages = with unstable; [
    nixd
    nil
  ];
  # catppuccin.zed = {
  #   enable = true;
  #   flavor = "mocha";
  #   icons = {
  #     enable = true;
  #     flavor = "mocha";
  #   };
  # };
  programs.zed-editor = {
    enable = true;
    package = unstable.zed-editor;
    extensions = [
      "nix"
      "toml"
      "rust"
    ];
    userSettings = {
      vim_mode = true;
      terminal = {
        shell = {
          program = "fish";
        };
      };
      # ... other settings
    };
    # Recommended: Enable nix-ld to help LSP servers resolve libraries
    # programs.nix-ld.enable = true; # (if using the system-wide nix-ld)
  };

  # ... other configurations
}
