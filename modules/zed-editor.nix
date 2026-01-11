{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.editor.zed {
  # ... other configurations
  home.packages = with pkgs; [
    nixd
    nil
  ];
  catppuccin.zed = {
    enable = true;
    flavor = "mocha";
    icons = {
      enable = true;
      flavor = "mocha";
    };
  };
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
    ];
    userSettings = {
      vim_mode = true;
      # ... other settings
    };
    # Recommended: Enable nix-ld to help LSP servers resolve libraries
    # programs.nix-ld.enable = true; # (if using the system-wide nix-ld)
  };

  # ... other configurations
}
