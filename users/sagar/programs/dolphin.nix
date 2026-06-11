{ config, pkgs, ... }:

let
  # The raw Tokyo Night color scheme content for KDE applications.
  tokyoNightColors = ''
    [ColorEffects:Disabled]
    Color=56,56,56
    ColorAmount=0.15000000000000002
    ColorEffect=2
    ContrastAmount=0.8
    ContrastEffect=1
    IntensityAmount=-1
    IntensityEffect=2

    [ColorEffects:Inactive]
    ChangeSelectionColor=true
    Color=112,111,110
    ColorAmount=0.025
    ColorEffect=2
    ContrastAmount=0.1
    ContrastEffect=2
    Enable=false
    IntensityAmount=0
    IntensityEffect=0

    [Colors:Button]
    BackgroundAlternate=157,221,203
    BackgroundNormal=44,45,55
    DecorationFocus=164,185,239
    DecorationHover=164,185,239
    ForegroundActive=164,185,239
    ForegroundInactive=120,124,153
    ForegroundLink=164,185,239
    ForegroundNegative=226,140,140
    ForegroundNeutral=247,193,150
    ForegroundNormal=215,218,224
    ForegroundPositive=179,225,163
    ForegroundVisited=173,142,230

    [Colors:Complementary]
    BackgroundAlternate=157,221,203
    BackgroundNormal=30,30,41
    DecorationFocus=164,185,239
    DecorationHover=164,185,239
    ForegroundActive=164,185,239
    ForegroundInactive=110,108,124
    ForegroundLink=164,185,239
    ForegroundNegative=226,140,140
    ForegroundNeutral=247,193,150
    ForegroundNormal=215,218,224
    ForegroundPositive=179,225,163
    ForegroundVisited=198,170,232

    [Colors:Header]
    BackgroundAlternate=30,30,41
    BackgroundNormal=30,30,41
    DecorationFocus=164,185,239
    DecorationHover=164,185,239
    ForegroundActive=164,185,239
    ForegroundInactive=110,108,124
    ForegroundLink=164,185,239
    ForegroundNegative=226,140,140
    ForegroundNeutral=247,193,150
    ForegroundNormal=215,218,224
    ForegroundPositive=179,225,163
    ForegroundVisited=198,170,232

    [Colors:Header][Inactive]
    BackgroundAlternate=49,54,59
    BackgroundNormal=22,22,29
    DecorationFocus=61,174,233
    DecorationHover=61,174,233
    ForegroundActive=61,174,233
    ForegroundInactive=161,169,177
    ForegroundLink=29,153,243
    ForegroundNegative=218,68,83
    ForegroundNeutral=246,116,0
    ForegroundNormal=252,252,252
    ForegroundPositive=39,174,96
    ForegroundVisited=155,89,182

    [Colors:Selection]
    BackgroundAlternate=157,221,203
    BackgroundNormal=164,187,239
    DecorationFocus=30,30,41
    DecorationHover=30,30,41
    ForegroundActive=21,18,28
    ForegroundInactive=120,124,153
    ForegroundLink=21,18,28
    ForegroundNegative=225,139,139
    ForegroundNeutral=247,193,150
    ForegroundNormal=20,21,30
    ForegroundPositive=179,225,163
    ForegroundVisited=173,142,230

    [Colors:Tooltip]
    BackgroundAlternate=22,22,29
    BackgroundNormal=26,27,38
    DecorationFocus=164,185,239
    DecorationHover=164,185,239
    ForegroundActive=164,185,239
    ForegroundInactive=120,124,153
    ForegroundLink=164,185,239
    ForegroundNegative=226,140,140
    ForegroundNeutral=247,193,150
    ForegroundNormal=215,218,224
    ForegroundPositive=179,225,163
    ForegroundVisited=173,142,230

    [Colors:View]
    BackgroundAlternate=22,22,29
    BackgroundNormal=26,27,38
    DecorationFocus=164,185,239
    DecorationHover=164,185,239
    ForegroundActive=164,185,239
    ForegroundInactive=120,124,153
    ForegroundLink=164,185,239
    ForegroundNegative=226,140,140
    ForegroundNeutral=247,193,150
    ForegroundNormal=215,218,224
    ForegroundPositive=179,225,163
    ForegroundVisited=173,142,230

    [Colors:Window]
    BackgroundAlternate=22,22,29
    BackgroundNormal=26,27,38
    DecorationFocus=164,185,239
    DecorationHover=164,185,239
    ForegroundActive=164,185,239
    ForegroundInactive=120,124,153
    ForegroundLink=164,185,239
    ForegroundNegative=226,140,140
    ForegroundNeutral=247,193,150
    ForegroundNormal=215,218,224
    ForegroundPositive=179,225,163
    ForegroundVisited=173,142,230

    [General]
    ColorScheme=TokyoNight
    Name=Tokyo Night
    shadeSortColumn=true

    [KDE]
    contrast=4

    [WM]
    activeBackground=26,27,38
    activeBlend=215,218,224
    activeForeground=215,218,224
    inactiveBackground=26,27,38
    inactiveBlend=110,108,124
    inactiveForeground=110,108,124
  '';
in
{
  # Dolphin: A highly customizable, Wayland-native GUI file manager.
  home.packages = with pkgs; [
    kdePackages.dolphin                  # Core Dolphin package (Qt6-based).
    kdePackages.kdegraphics-thumbnailers # Adds image/graphics previews.
    kdePackages.ffmpegthumbs             # Adds video thumbnail previews.
    kdePackages.kio-extras               # Provides advanced network protocols (SFTP, SMB, etc.).
    kdePackages.qtsvg                    # Crucial for rendering SVG icons like candy-icons in Qt applications.
    libsForQt5.qt5ct                     # Provides the theme plugin (libqt5ct.so) for Qt5 apps.
    kdePackages.qt6ct                    # Provides the theme plugin (libqt6ct.so) for Qt6 apps (Dolphin).
  ];

  # Declaratively configure qt5ct/qt6ct settings to use the Fusion engine
  # with Noctalia's generated Tokyo Night palette and Candy Icons.
  xdg.configFile."qt5ct/qt5ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt5ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=candy-icons
    style=Fusion
  '';

  xdg.configFile."qt6ct/qt6ct.conf".text = ''
    [Appearance]
    color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
    custom_palette=true
    icon_theme=candy-icons
    style=Fusion
  '';

  # Write the color scheme file to the local KDE color-schemes directory.
  # This makes the "TokyoNight" scheme discoverable by Dolphin.
  xdg.dataFile."color-schemes/TokyoNight.colors".text = tokyoNightColors;

  # Declarative kdeglobals for Dolphin and KDE applications.
  # TEMPORARILY set to "BreezeDark" for testing purposes.
  xdg.configFile."kdeglobals".text = ''
    [General]
    ColorScheme=BreezeDark
    Name=Breeze Dark
    shadeSortColumn=true

    [Icons]
    Theme=candy-icons
  '';
}
