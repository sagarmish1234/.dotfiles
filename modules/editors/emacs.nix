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
  };
  services.emacs = {
    enable = true;
  };
}
