{
  lib,
  feature,
  pkgs,
  unstable,
  ...
}:
lib.mkIf feature.editor.emacs {
  home.packages = with unstable; [ nixfmt-rfc-style ];
  programs.emacs = {
    enable = true;
    package = unstable.emacs-pgtk;
    extraPackages = epkgs: [
    epkgs.vterm
  ];
  };
  services.emacs = {
    enable = true;
    package = unstable.emacs-pgtk;
  };
}
