{
  lib,
  feature,
  ...
}:
lib.mkIf feature.editor.vscode {
  programs.vscode = {
    enable = true;
  };
}
