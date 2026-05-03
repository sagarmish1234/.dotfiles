{
  pkgs,
  inputs,
  unstable,
  ...
}:
{
  home.packages = with unstable; [
    codecrafters-cli
    gemini-cli
  ];
}
