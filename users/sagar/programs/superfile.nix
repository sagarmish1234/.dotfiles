{
  config,
  pkgs,
  ...
}: {
  programs.superfile = {
    enable = true;
    settings = {
      theme = "tokyonight";
    };
  };
}
