{
  pkgs,
  lib,
  feature,
  unstable,
  ...
}:
lib.mkIf feature.dev.javascript {
  home.packages = with unstable; [
    # nodejs
    #nodePackages.pnpm
    #nodePackages.yarn
    #nodePackages.typescript
    #nodePackages.typescript-language-server
    #nodePackages.eslint
    #nodePackages.prettier
    #nodePackages.nodemon
    #deno
    bun
    typescript-go
  ];
}
