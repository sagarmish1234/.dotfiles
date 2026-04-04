{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.editor.emacs {
  home.packages = with pkgs; [ nixfmt ];
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [
    epkgs.vterm
  ];
  };
  services.emacs = {
    enable = true;
  };
}
