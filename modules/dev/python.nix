{
  pkgs,
  lib,
  feature,
  unstable,
  ...
}:
lib.mkIf feature.dev.python {
  home.packages = with unstable; [
    python3
    python313Packages.markdown
    # python3Packages.pip
    # python3Packages.virtualenv
    # uv
    # poetry
    #python3Packages.black
    #python3Packages.pylint
    # python3Packages.pytest
    #python3Packages.ipython
    #pyright
    #ruff
  ];
}
