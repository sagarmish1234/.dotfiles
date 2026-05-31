{ inputs, pkgs, ... }:

{
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    package = inputs.zen-browser.packages.${pkgs.system}.beta;
    
    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      InstallAddonsPermission = {
        Default = true;
      };
      ExtensionInstallSources = [
        "https://addons.mozilla.org/"
      ];
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
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
        "browsec@browsec.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/browsec/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };

    profiles.sagar = {
      id = 0;
      name = "sagar";
      isDefault = true;

      search = {
        force = true;
        default = "google";
        engines = {
          "searxng" = {
            urls = [ { template = "https://search.sndh.dev/search?q={searchTerms}"; } ];
            icon = "https://search.sndh.dev/favicon.ico";
            definedAliases = [ "@sx" ];
          };
          "amazon" = {
            urls = [ { template = "https://amazon.de/s?k={searchTerms}"; } ];
            icon = "https://amazon.de/favicon.ico";
            definedAliases = [ "@a" ];
          };
          "protondb" = {
            urls = [ { template = "https://protondb.com/search?q={searchTerms}"; } ];
            icon = "https://protondb.com/favicon.ico";
            definedAliases = [ "@pdb" ];
          };
          "github" = {
            urls = [ { template = "https://github.com/search?q={searchTerms}"; } ];
            icon = "https://github.com/favicon.ico";
            definedAliases = [ "@gh" ];
          };
          "alternativeto" = {
            urls = [ { template = "https://alternativeto.net/browse/search/?q={searchTerms}"; } ];
            icon = "https://alternativeto.net/favicon.ico";
            definedAliases = [ "@alt" ];
          };
          "youtube" = {
            urls = [ { template = "https://www.youtube.com/results?search_query={searchTerms}"; } ];
            icon = "https://www.youtube.com/favicon.ico";
            definedAliases = [ "@yt" ];
          };
          "nixos-wiki" = {
            urls = [ { template = "https://wiki.nixos.org/w/index.php?search={searchTerms}"; } ];
            icon = "https://wiki.nixos.org/favicon.png";
            definedAliases = [ "@nw" ];
          };
          "nüschtos-search" = {
            urls = [ { template = "https://search.nüschtos.de/?query={searchTerms}"; } ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@no" ];
          };
          "nix-packages" = {
            urls = [
              {
                template = "https://search.nixos.org/packages";
                params = [
                  {
                    name = "channel";
                    value = "unstable";
                  }
                  {
                    name = "type";
                    value = "packages";
                  }
                  {
                    name = "query";
                    value = "{searchTerms}";
                  }
                ];
              }
            ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };
          "nixpkgs-pr" = {
            urls = [ { template = "https://nixpkgs-tracker.ocfox.me/?pr={searchTerms}"; } ];
            icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@npr" ];
          };
          "subreddit" = {
            urls = [ { template = "https://reddit.com/r/{searchTerms}"; } ];
            icon = "https://reddit.com/favicon.png";
            definedAliases = [ "r/" ];
          };
        };
      };

      bookmarks = {
        force = true;
        settings = [
          {
            name = "Toolbar";
            toolbar = true;
            bookmarks = [
              {
                name = "NixOS Search";
                url = "https://search.nixos.org/packages";
              }
              {
                name = "GitHub";
                url = "https://github.com/";
              }
              {
                name = "Pirate Bay";
                url = "https://thepiratebay.org/";
              }
              {
                name = "Animepahe";
                url = "https://animepahe.pw/";
              }
            ];
          }
        ];
      };

      settings = {
        # Hardware Acceleration & Wayland (from current config)
        "widget.wayland.enabled" = true;
        "media.ffmpeg.vaapi.enabled" = true;
        "media.rdd-ffmpeg.enabled" = true;
        "widget.dmabuf.force-enabled" = true;
        "gfx.webrender.all" = true;
        "layers.acceleration.force-enabled" = true;
        "media.av1.enabled" = false;
        "media.navigator.mediadatadecoder_vpx_enabled" = true;

        # My Overrides (from old config)
        "browser.ctrlTab.sortByRecentlyUsed" = true;
        "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;
        "signon.autofillForms" = false;
        "signon.rememberSignons" = false;
        "signon.generation.enabled" = false;
        "signon.management.page.breach-alerts.enabled" = true;

        # Fastfox
        "gfx.content.skia-font-cache-size" = 32;
        "gfx.canvas.accelerated.cache-items" = 32768;
        "gfx.canvas.accelerated.cache-size" = 4096;
        "webgl.max-size" = 16384;
        "browser.cache.disk.enable" = false;
        "browser.cache.memory.capacity" = 131072;
        "browser.cache.memory.max_entry_size" = 20480;
        "browser.sessionhistory.max_total_viewers" = 4;
        "browser.sessionstore.max_tabs_undo" = 10;
        "media.memory_cache_max_size" = 262144;
        "media.memory_caches_combined_limit_kb" = 1048576;
        "image.cache.size" = 10485760;
        "network.http.max-connections" = 1800;
        "network.http.max-persistent-connections-per-server" = 10;

        # Securefox
        "browser.contentblocking.category" = "strict";
        "privacy.globalprivacycontrol.enabled" = true;
        "security.OCSP.enabled" = 0;
        "security.ssl.treat_unsafe_negotiation_as_broken" = true;
        "privacy.history.custom" = true;
        "browser.privatebrowsing.resetPBM.enabled" = true;
        "browser.urlbar.trimHttps" = true;
        "browser.search.suggest.enabled" = false;
        "editor.truncate_user_pastes" = false;
        "security.mixed_content.block_display_content" = true;
        "pdfjs.enableScripting" = false;
        
        # Extension Fixes
        "extensions.enabledScopes" = 15; # Enable all scopes
        "extensions.autoDisableScopes" = 0; # Don't auto-disable extensions
        "extensions.getAddons.cache.enabled" = false;

        # Telemetry
        "datareporting.policy.dataSubmissionEnabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.archive.enabled" = false;

        # Peskyfox
        "browser.shell.checkDefaultBrowser" = false;
        "browser.aboutConfig.showWarning" = false;
        "browser.aboutwelcome.enabled" = false;
        "browser.ml.enable" = false;
        "browser.ml.chat.enabled" = false;
        "full-screen-api.warning.timeout" = 0;
        "browser.urlbar.trending.featureGate" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;

        # UI State
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

        # Theme Support
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };

  # Catppuccin Mocha Lavender Theme
  # Note: Ideally we should find the profile directory dynamically, but since we define the profile 'sagar', 
  # Home Manager usually puts it in .zen/sagar or similar. 
  # However, Zen often uses random hashes. If the previous config used np8fsws6, 
  # it might have been specific to that installation.
  # For now, I'll keep the ones from current config but the user might need to adjust the path.
  home.file.".zen/np8fsws6.Default Profile/chrome/userChrome.css".source = "${inputs.catppuccin-zen}/themes/mocha/userChrome.css";
  home.file.".zen/np8fsws6.Default Profile/chrome/userContent.css".source = "${inputs.catppuccin-zen}/themes/mocha/userContent.css";
  home.file.".zen/np8fsws6.Default Profile/chrome/zen-logo.svg".source = "${inputs.catppuccin-zen}/themes/mocha/zen-logo.svg";

  home.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
  };

  # Custom Desktop Entry for Zen Beta
  xdg.desktopEntries.zen-beta = {
    name = "Zen Browser";
    genericName = "Web Browser";
    exec = "zen-beta --name zen-beta %U";
    icon = "zen";
    terminal = false;
    categories = [ "Network" "WebBrowser" ];
    mimeType = [
      "text/html"
      "text/xml"
      "application/xhtml+xml"
      "application/vnd.mozilla.xul+xml"
      "x-scheme-handler/http"
      "x-scheme-handler/https"
    ];
    settings = {
      StartupNotify = "true";
      StartupWMClass = "zen-beta";
    };
  };
}
