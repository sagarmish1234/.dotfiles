{ inputs, pkgs, ... }:
let
  defaults = import ./_firefoxSettings.nix { inherit pkgs; };
in
{
  imports = [ inputs.zen-browser.homeModules.beta ];

  programs.zen-browser = {
    enable = true;
    policies = {
      ExtensionSettings = {
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      inherit (defaults) settings search;
    };
  };
}
