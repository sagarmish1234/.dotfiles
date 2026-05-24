{
  lib,
  feature,
  unstable,
  ...
}:
lib.mkIf feature.editor.vscode {
  programs.vscode = {
    enable = true;
    package = unstable.vscode;
  };
}
