{ inputs, pkgs, ... }:

let
  noctalia-plugins-src = pkgs.fetchFromGitHub {
    owner = "whereareiam";
    repo = "noctalia-plugins";
    rev = "release";
    hash = "sha256-n3SIMQxeB/ADMsGA3CJDIgx7FhfXiFh4mFXkwo+sCy0=";
  };

  noctalia-official-plugins-src = pkgs.fetchFromGitHub {
    owner = "noctalia-dev";
    repo = "noctalia-plugins";
    rev = "main";
    hash = "sha256-ePWMazPbuSl4Gw43kF6il645got10McPBXZ4ll93n7s=";
  };

  hyprctl = "${pkgs.hyprland}/bin/hyprctl";
  jq = "${pkgs.jq}/bin/jq";

  # Dedicated script to handle window switching with fullscreen preservation
  switch-script = pkgs.writeShellScript "tabber-focus-switch" ''
    TARGET="$1"
    # Ensure address starts with 0x
    [[ "$TARGET" != 0x* ]] && TARGET="0x$TARGET"
    
    # Get current active window's fullscreen state
    FW=$(${hyprctl} activewindow -j | ${jq} -r '.fullscreen // 0')
    
    # If activewindow is 0 (e.g. switcher took focus), try to find the most recently active client
    if [ "$FW" -eq 0 ]; then
       FW=$(${hyprctl} clients -j | ${jq} -r '.[] | select(.focusHistoryID == 0) | .fullscreen // 0')
    fi

    # Focus the target window
    ${hyprctl} dispatch focuswindow "address:$TARGET"
    
    # Wait for Hyprland to process focus change
    sleep 0.12
    
    # Check target window's current state to avoid accidental toggling
    NEW_FW=$(${hyprctl} clients -j | ${jq} -r ".[] | select(.address == \"$TARGET\") | .fullscreen // 0")
    
    # Only apply if previous window was fullscreen and target is not
    if [ "$FW" -ne 0 ] && [ "$FW" -ne "$NEW_FW" ]; then
        ${hyprctl} dispatch fullscreen "$FW"
    fi
    
    # Bring to top
    ${hyprctl} dispatch alterzorder "top,address:$TARGET"
  '';

  oldLine = ''Quickshell.execDetached(["bash", "-lc", "sleep 0.08; hyprctl dispatch focuswindow 'address:" + windowAddress + "' >/dev/null 2>&1 || true; hyprctl dispatch alterzorder 'top,address:" + windowAddress + "' >/dev/null 2>&1 || true"]);'';
  newLine = ''Quickshell.execDetached(["${switch-script}", windowAddress]);'';

  noctalia-plugins = pkgs.runCommand "noctalia-plugins-patched"
    {
      inherit oldLine newLine;
    }
    ''
      cp -r ${noctalia-plugins-src} $out
      chmod -R +w $out
      substituteInPlace $out/tabber/Services/TabberController.qml \
        --replace-fail "$oldLine" "$newLine"
    '';
in
{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  xdg.configFile."noctalia/plugins/tabber".source = "${noctalia-plugins}/tabber";
  xdg.configFile."noctalia/plugins/wallcards".source = "${noctalia-official-plugins-src}/wallcards";
xdg.configFile."noctalia/plugins.json".text = builtins.toJSON {
    sources = [
      {
        enabled = true;
        name = "Noctalia Plugins";
        url = "https://github.com/noctalia-dev/noctalia-plugins";
      }
      {
        enabled = true;
        name = "Tabber";
        url = "https://github.com/whereareiam/noctalia-plugins";
      }
    ];
    states = {
      tabber = {
        enabled = true;
      };
      wallcards = {
        enabled = true;
      };
    };
    version = 2;
  };
  programs.noctalia-shell = {
    enable = true;
    package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default.overrideAttrs (old: {
      patches = (old.patches or [ ]) ++ [
        ./patches/noctalia-shell-custom.patch
      ];
      buildInputs = (old.buildInputs or [ ]) ++ [
        pkgs.qt6.qtsvg
        pkgs.qt6.qtwayland
        pkgs.adwaita-qt
        pkgs.qt6.qt5compat
        pkgs.adwaita-qt6
        pkgs.libadwaita
        pkgs.gnome-themes-extra
      ];
      preFixup =
        (old.preFixup or "")
        + ''
          qtWrapperArgs+=(
            --set XDG_ICON_THEME candy-icons
            --set GTK_THEME Adwaita:dark
            --set QT_QPA_PLATFORMTHEME gtk3
            --prefix XDG_DATA_DIRS : "${pkgs.candy-icons}/share"
            --prefix XDG_DATA_DIRS : "${pkgs.adwaita-icon-theme}/share"
            --prefix XDG_DATA_DIRS : "${pkgs.hicolor-icon-theme}/share"
            --prefix GTK_PATH : "${pkgs.gnome-themes-extra}/lib/gtk-2.0"
            --prefix GTK_PATH : "${pkgs.gnome-themes-extra}/lib/gtk-3.0"
          )
        '';
    });
    systemd.enable = false;
    settings = {
      appLauncher = {
        autoPasteClipboard = false;
        clipboardWrapText = true;
        customLaunchPrefix = "";
        customLaunchPrefixEnabled = false;
        enableClipPreview = true;
        enableClipboardHistory = false;
        iconMode = "native";
        ignoreMouseInput = false;
        pinnedApps = [ ];
        position = "center";
        screenshotAnnotationTool = "";
        showCategories = true;
        showIconBackground = false;
        sortByMostUsed = true;
        terminalCommand = "launch-tui ";
        useApp2Unit = false;
        viewMode = "list";
      };

      audio = {
        cavaFrameRate = 30;
        mprisBlacklist = [ ];
        preferredPlayer = "";
        visualizerType = "linear";
        volumeFeedback = false;
        volumeOverdrive = true;
        volumeStep = 5;
      };

      bar = {
        backgroundOpacity = 0.95;
        capsuleOpacity = 1;
        density = "comfortable";
        exclusive = true;
        floating = true;
        hideOnOverview = false;
        marginHorizontal = 8;
        marginVertical = 8;
        monitors = [ ];
        outerCorners = true;
        position = "top";
        screenOverrides = [ ];
        showCapsule = false;
        showOutline = false;
        useSeparateOpacity = false;

        widgets = {
          center = [
            {
              characterCount = 2;
              colorizeIcons = false;
              enableScrollWheel = true;
              followFocusedScreen = false;
              groupedBorderOpacity = 0.85;
              hideUnoccupied = false;
              iconScale = 0.8;
              id = "Workspace";
              labelMode = "index";
              showApplications = false;
              showLabelsOnlyWhenOccupied = true;
              unfocusedIconsOpacity = 1;
            }
          ];

          left = [
            {
              customFont = "";
              formatHorizontal = "HH:mm ddd, MMM dd";
              formatVertical = "HH mm - dd MM";
              id = "Clock";
              tooltipFormat = "HH:mm ddd, MMM dd";
              useCustomFont = false;
              usePrimaryColor = true;
            }
            {
              compactMode = true;
              diskPath = "/";
              id = "SystemMonitor";
              showCpuTemp = true;
              showCpuUsage = true;
              showDiskUsage = false;
              showGpuTemp = false;
              showLoadAverage = false;
              showMemoryAsPercent = false;
              showMemoryUsage = true;
              showNetworkStats = false;
              showSwapUsage = false;
              useMonospaceFont = true;
              usePrimaryColor = false;
            }
            {
              colorizeIcons = false;
              hideMode = "hidden";
              id = "ActiveWindow";
              maxWidth = 145;
              scrollingMode = "hover";
              showIcon = true;
              useFixedWidth = false;
            }
            {
              compactMode = false;
              compactShowAlbumArt = true;
              compactShowVisualizer = false;
              hideMode = "hidden";
              hideWhenIdle = false;
              id = "MediaMini";
              maxWidth = 145;
              panelShowAlbumArt = true;
              panelShowVisualizer = true;
              scrollingMode = "hover";
              showAlbumArt = true;
              showArtistFirst = true;
              showProgressRing = true;
              showVisualizer = false;
              useFixedWidth = false;
              visualizerType = "Wave";
            }
          ];

          right = [
            {
              blacklist = [ ];
              colorizeIcons = false;
              drawerEnabled = true;
              hidePassive = false;
              id = "Tray";
              pinned = [ ];
            }
            {
              id = "Network";
            }
            {
              hideWhenZero = false;
              hideWhenZeroUnread = false;
              id = "NotificationHistory";
              showUnreadBadge = true;
            }
            {
              id = "Bluetooth";
            }
            {
              deviceNativePath = "";
              displayMode = "icon-always";
              hideIfIdle = false;
              hideIfNotDetected = true;
              id = "Battery";
              showNoctaliaPerformance = false;
              showPowerProfiles = false;
              warningThreshold = 30;
            }
            {
              displayMode = "onhover";
              id = "Volume";
              middleClickCommand = "pwvucontrol || pavucontrol";
            }
            {
              displayMode = "onhover";
              id = "Brightness";
            }
            {
              colorizeDistroLogo = false;
              colorizeSystemIcon = "none";
              customIconPath = "";
              enableColorization = false;
              icon = "noctalia";
              id = "ControlCenter";
              useDistroLogo = true;
            }
          ];
        };
      };

      brightness = {
        brightnessStep = 5;
        enableDdcSupport = false;
        enforceMinimum = true;
      };

      calendar = {
        cards = [
          {
            enabled = true;
            id = "calendar-header-card";
          }
          {
            enabled = true;
            id = "calendar-month-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
        ];
      };

      colorSchemes = {
        darkMode = true;
        generationMethod = "tonal-spot";
        manualSunrise = "06:30";
        manualSunset = "18:30";
        monitorForColors = "";
        predefinedScheme = "Catppuccin";
        schedulingMode = "off";
        useWallpaperColors = false;
      };

      controlCenter = {
        cards = [
          {
            enabled = true;
            id = "profile-card";
          }
          {
            enabled = false;
            id = "shortcuts-card";
          }
          {
            enabled = false;
            id = "audio-card";
          }
          {
            enabled = false;
            id = "brightness-card";
          }
          {
            enabled = true;
            id = "weather-card";
          }
          {
            enabled = true;
            id = "media-sysmon-card";
          }
        ];

        diskPath = "/";
        position = "close_to_bar_button";

        shortcuts = {
          left = [
            { id = "Network"; }
            { id = "Bluetooth"; }
            { id = "WallpaperSelector"; }
          ];
          right = [
            { id = "Notifications"; }
            { id = "PowerProfile"; }
            { id = "KeepAwake"; }
            { id = "NightLight"; }
          ];
        };
      };

      desktopWidgets = {
        enabled = false;
        gridSnap = false;
        monitorWidgets = [ ];
      };

      dock = {
        animationSpeed = 1;
        backgroundOpacity = 1;
        colorizeIcons = false;
        deadOpacity = 0.6;
        displayMode = "auto_hide";
        enabled = false;
        floatingRatio = 1;
        inactiveIndicators = false;
        monitors = [ ];
        onlySameOutput = true;
        pinnedApps = [ ];
        pinnedStatic = false;
        position = "bottom";
        size = 1;
      };

      general = {
        allowPanelsOnScreenWithoutBar = true;
        animationDisabled = false;
        animationSpeed = 0.75;
        avatarImage = "/home/sagar/.face";
        boxRadiusRatio = 1;
        compactLockScreen = false;
        dimmerOpacity = 0;
        enableBlurBehind = true;
        enableLockScreenCountdown = true;
        enableShadows = true;
        forceBlackScreenCorners = false;
        iRadiusRatio = 1;
        language = "";
        lockOnSuspend = true;
        lockScreenBlur = 0.8;
        lockScreenTint = 0.2;
        lockScreenWallpaper = "/home/sagar/.cache/current_wallpaper";
        lockScreenCountdownDuration = 10000;
        radiusRatio = 1;
        scaleRatio = 1;
        screenRadiusRatio = 1;
        shadowDirection = "bottom_right";
        shadowOffsetX = 1;
        shadowOffsetY = 1;
        showChangelogOnStartup = true;
        showHibernateOnLockScreen = false;
        showScreenCorners = false;
        showSessionButtonsOnLockScreen = true;
        telemetryEnabled = false;
      };

      hooks = {
        darkModeChange = "";
        enabled = false;
        performanceModeDisabled = "";
        performanceModeEnabled = "";
        screenLock = "";
        screenUnlock = "";
        session = "";
        startup = "";
        wallpaperChange = "";
      };

      location = {
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        hideWeatherCityName = false;
        hideWeatherTimezone = false;
        name = "Kolkata, India";
        showCalendarEvents = true;
        showCalendarWeather = true;
        showWeekNumberInCalendar = false;
        use12hourFormat = true;
        useFahrenheit = false;
        weatherEnabled = true;
        weatherShowEffects = true;
      };

      network = {
        bluetoothDetailsViewMode = "grid";
        bluetoothEnabled = false;
        bluetoothHideUnnamedDevices = false;
        bluetoothRssiPollIntervalMs = 10000;
        bluetoothRssiPollingEnabled = false;
        wifiDetailsViewMode = "grid";
        wifiEnabled = true;
      };

      nightLight = {
        autoSchedule = true;
        dayTemp = "6500";
        enabled = false;
        forced = false;
        manualSunrise = "06:30";
        manualSunset = "18:30";
        nightTemp = "4000";
      };

      notifications = {
        backgroundOpacity = 0.85;
        criticalUrgencyDuration = 15;
        enableKeyboardLayoutToast = true;
        enableMediaToast = false;
        enabled = true;
        location = "top_right";
        lowUrgencyDuration = 3;
        monitors = [ ];
        normalUrgencyDuration = 8;
        overlayLayer = true;
        respectExpireTimeout = false;

        saveToHistory = {
          critical = true;
          low = true;
          normal = true;
        };

        sounds = {
          criticalSoundFile = "";
          enabled = false;
          excludedApps = "discord,firefox,chrome,chromium,edge";
          lowSoundFile = "";
          normalSoundFile = "";
          separateSounds = false;
          volume = 0.5;
        };
      };

      osd = {
        autoHideMs = 2000;
        backgroundOpacity = 0.85;
        enabled = true;
        enabledTypes = [
          0
          1
          2
        ];
        location = "top_right";
        monitors = [ ];
        overlayLayer = true;
      };

      sessionMenu = {
        countdownDuration = 10000;
        enableCountdown = false;
        largeButtonsLayout = "grid";
        largeButtonsStyle = false;
        position = "center";

        powerOptions = [
          {
            action = "lock";
            enabled = true;
            keybind = "1";
          }
          {
            action = "suspend";
            enabled = true;
            keybind = "2";
          }
          {
            action = "hibernate";
            enabled = true;
            keybind = "3";
          }
          {
            action = "reboot";
            enabled = true;
            keybind = "4";
          }
          {
            action = "logout";
            enabled = true;
            keybind = "5";
          }
          {
            action = "shutdown";
            enabled = true;
            keybind = "6";
          }
        ];

        showHeader = true;
        showKeybinds = true;
      };

      settingsVersion = 43;

      systemMonitor = {
        cpuCriticalThreshold = 90;
        cpuPollingInterval = 3000;
        cpuWarningThreshold = 80;
        criticalColor = "";
        diskCriticalThreshold = 90;
        diskPollingInterval = 30000;
        diskWarningThreshold = 80;
        enableDgpuMonitoring = false;
        externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
        gpuCriticalThreshold = 90;
        gpuPollingInterval = 3000;
        gpuWarningThreshold = 80;
        loadAvgPollingInterval = 3000;
        memCriticalThreshold = 90;
        memPollingInterval = 3000;
        memWarningThreshold = 80;
        networkPollingInterval = 3000;
        swapCriticalThreshold = 90;
        swapWarningThreshold = 80;
        tempCriticalThreshold = 90;
        tempPollingInterval = 3000;
        tempWarningThreshold = 80;
        useCustomColors = false;
        warningColor = "";
      };

      templates = {
        activeTemplates = [
          {
            enabled = true;
            id = "gtk";
          }
          {
            enabled = true;
            id = "qt";
          }
        ];
        enableUserTheming = true;
      };

      ui = {
        bluetoothDetailsViewMode = "grid";
        bluetoothHideUnnamedDevices = false;
        boxBorderEnabled = false;
        fontDefault = "JetBrainsMono Nerd Font";
        fontDefaultScale = 1;
        fontFixed = "JetBrainsMono Nerd Font Mono";
        fontFixedScale = 1;
        networkPanelView = "wifi";
        panelBackgroundOpacity = 0.65;
        panelsAttachedToBar = true;
        translucentWidgets = true;
        settingsPanelMode = "attached";
        tooltipsEnabled = true;
        wifiDetailsViewMode = "grid";
      };

      wallpaper = {
        automationEnabled = false;
        directory = "/home/sagar/Pictures/Wallpapers";
        enableMultiMonitorDirectories = false;
        enabled = true;
        fillColor = "#000000";
        fillMode = "crop";
        hideWallpaperFilenames = false;
        monitorDirectories = [ ];
        overviewEnabled = true;
        panelPosition = "follow_bar";
        randomIntervalSec = 300;
        setWallpaperOnAllMonitors = true;
        showHiddenFiles = false;
        solidColor = "#1a1a2e";
        transitionDuration = 1500;
        transitionEdgeSmoothness = 0.05;
        transitionType = "random";
        useSolidColor = false;
        useWallhaven = false;
        viewMode = "single";
        wallhavenApiKey = "";
        wallhavenCategories = "111";
        wallhavenOrder = "desc";
        wallhavenPurity = "100";
        wallhavenQuery = "";
        wallhavenRatios = "";
        wallhavenResolutionHeight = "";
        wallhavenResolutionMode = "atleast";
        wallhavenResolutionWidth = "";
        wallhavenSorting = "relevance";
        wallpaperChangeMode = "random";
      };
    };
  };
}
