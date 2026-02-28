{
  pkgs,
  lib,
  feature,
  ...
}:
lib.mkIf feature.dev.javascript {
  home.packages = with pkgs; [
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
