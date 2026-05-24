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
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{7493aaa9-f9ba-4705-9e60-f421f1d1844b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          installation_mode = "force_installed";
        };
        "{762f9885-ad34-4054-9467-3367184478b0}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislike/latest.xpi";
          installation_mode = "force_installed";
        };
        "browsec@browsec.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/browsec/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
    profiles.default = {
      id = 0;
      name = "default";
      isDefault = true;
      inherit (defaults) search;
      settings = defaults.settings // {
        "browser.uiCustomization.state" = builtins.toJSON {
          placements = {
            widget-overflow-fixed-list = [ ];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "browsec_browsec_com-browser-action"
            ];
            toolbar-menubar = [ "menubar-items" ];
            TabsToolbar = [
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];
            PersonalToolbar = [ "personal-bookmarks" ];
          };
          seen = [
            "browsec_browsec_com-browser-action"
            "developer-button"
          ];
          dirtyAreaCache = [
            "nav-bar"
            "PersonalToolbar"
            "toolbar-menubar"
            "TabsToolbar"
          ];
          currentVersion = 18;
          newElementCount = 4;
        };
      };
    };
  };
}
