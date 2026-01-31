{
  lib,
  feature,
  pkgs,
  ...
}:
lib.mkIf feature.editor.emacs {
  programs.emacs.enable = true;
}
