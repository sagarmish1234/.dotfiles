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
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "toml"
      "rust"
    ];
    userSettings = {
      theme = {
        mode = "dark";
        dark = "Carbonfox - blurred";
        light = "Carbonfox - blurred";
      };
      vim_mode = true;
      # ... other settings
    };
    # Recommended: Enable nix-ld to help LSP servers resolve libraries
    # programs.nix-ld.enable = true; # (if using the system-wide nix-ld)
  };

  # ... other configurations
}
