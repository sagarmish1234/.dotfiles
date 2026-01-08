{ inputs, ... }:
{
  imports = [ inputs.walker.homeManagerModules.default ];
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
