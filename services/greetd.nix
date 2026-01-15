{
  lib,
  feature,
  ...
}:
lib.mkIf feature.services.displayManager.greetd {
  services.displayManager.ly = {
    enable = true;
    settings = {
      animation = "matrix"; # optional
      clock = true;
      clear_password = true;
      bigclock = false;
    };
  };
}
