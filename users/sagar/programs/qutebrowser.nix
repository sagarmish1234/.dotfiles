{
  inputs,
  pkgs,
  ...
}: {
  programs.qutebrowser = {
    enable = true;

    # Custom search engines for faster command-line search
    searchEngines = {
      DEFAULT = "https://duckduckgo.com/?q={}";
      g = "https://www.google.com/search?q={}";
      yt = "https://www.youtube.com/results?search_query={}";
      gh = "https://github.com/search?q={}";
      nix = "https://search.nixos.org/packages?channel=unstable&query={}";
      nixos = "https://search.nixos.org/options?query={}";
      hm = "https://home-manager-options.extranix.com/?query={}";
    };

    # Vim-style custom keybindings
    keyBindings = {
      normal = {
        # Play media via MPV directly
        "M" = "spawn mpv \${url}";
        ";M" = "hint links spawn mpv \${hint-url}";

        # Toggle tab bar visibility (Zen-style sidebar toggle)
        "xt" = "config-cycle tabs.show multiple never";

        # Quick tab navigation
        "J" = "tab-next";
        "K" = "tab-prev";

        # Zoom controls
        "zi" = "zoom-in";
        "zo" = "zoom-out";
        "zz" = "zoom";
      };
    };

    # Declarative setting overrides
    settings = {
      # Zen-like Layout (Vertical tabs on the left)
      tabs.position = "left";
      tabs.width = "15%";
      tabs.show = "multiple"; # Hide tab bar if only one tab is open
      
      # Clean Tab Titles (removes index numbers)
      tabs.title.format = "{audio}{current_title}";
      tabs.title.format_pinned = "{audio}";
      
      # Cozy spacing for tabs
      tabs.padding = {
        top = 6;
        bottom = 6;
        left = 10;
        right = 10;
      };

      # Hints: Style as modern rounded chips
      hints.radius = 4;
      hints.border = "1px solid #1a1b26"; # Tokyo Night dark border
      hints.padding = {
        top = 3;
        bottom = 3;
        left = 6;
        right = 6;
      };

      # Statusbar spacing
      statusbar.padding = {
        top = 6;
        bottom = 6;
        left = 8;
        right = 8;
      };

      # Hide scrollbar entirely for a clean, minimal look
      scrolling.bar = "never";
      scrolling.smooth = true;

      # Smart Forced Dark Mode (High-quality CIELAB rendering, preserves image colors)
      colors.webpage.darkmode.enabled = true;
      colors.webpage.darkmode.policy.images = "never";
      colors.webpage.darkmode.algorithm = "lightness-cielab";

      # Dark Startpage & Homepage
      url.default_page = "https://start.duckduckgo.com/?kae=d&k1=-1";
      url.start_pages = [ "https://start.duckduckgo.com/?kae=d&k1=-1" ];

      # Privacy & Content Controls
      content.autoplay = false; # Don't autoplay videos
      content.pdfjs = true;     # Open PDFs inside the browser

      # Adblocking & uBlock Origin Filters
      content.blocking.enabled = true;
      content.blocking.method = "both"; # Use both hosts and Brave adblock lists
      
      content.blocking.adblock.lists = [
        "https://easylist.to/easylist/easylist.txt"
        "https://easylist.to/easylist/easyprivacy.txt"
        "https://secure.fanboy.co.nz/fanboy-cookiemonster.txt"
        
        # uBlock Origin Official Filter Lists
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/filters.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/privacy.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/badware.txt"
        "https://raw.githubusercontent.com/uBlockOrigin/uAssets/master/filters/unbreak.txt"
      ];
    };
  };
}
