{
  lib,
  feature,
  inputs,
  ...
}:
lib.mkIf feature.launcher.walker {
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      keybinds.quick_activate = [
        "F1"
        "F2"
        "F3"
      ];
    };
  };

}
