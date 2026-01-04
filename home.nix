{ config, pkgs,inputs, lib, ... }:
{
imports = [
    ./modules/git.nix
    ./modules/ghostty.nix
    ./modules/vscode.nix
    ./modules/development.nix
    ./modules/walker.nix
    ./modules/starship.nix
    ./modules/fastfetch.nix
    # Add other modules here
  ];
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.sessionVariables = {
  EDITOR = "nvim";
};
programs.walker.enable = true;

programs.fish = {
  enable = true;
shellInit = "
      set fish_greeting
    ";
};
 wayland.windowManager.hyprland = {
    enable = true;
    # set the Hyprland and XDPH packages to null to use the ones from the NixOS module
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
      bind =
          [
            "$mod, F, exec, firefox"
            ", Print, exec, grimblast copy area"
            "$mod, space, exec, wofi --show drun --sort-order=alphabetical"
      "$mod SHIFT, SPACE, exec, pkill -SIGUSR1 waybar"
      # "$mod CTRL, SPACE, exec, ~/.local/share/omarchy/bin/swaybg-next"
      # "$mod SHIFT CTRL, SPACE, exec, ~/.local/share/omarchy/bin/omarchy-theme-next"
      "$mod, RETURN, exec, ghostty"
      "$mod, W, killactive,"
      "$mod, Backspace, killactive,"

      # End active session
      "$mod, ESCAPE, exec, hyprlock"
      "$mod SHIFT, ESCAPE, exit,"
      "$mod CTRL, ESCAPE, exec, reboot"
      "$mod SHIFT CTRL, ESCAPE, exec, systemctl poweroff"
      "$mod, K, exec, ~/.local/share/omarchy/bin/omarchy-show-keybindings"

      # Control tiling
      "$mod, J, togglesplit, # dwindle"
      "$mod, P, pseudo, # dwindle"
      "$mod, V, togglefloating,"
      "$mod SHIFT, Plus, fullscreen,"

      # Move focus with mainMod + arrow keys
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"

      # Switch workspaces with mainMod + [0-9]
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"
      "$mod, 0, workspace, 10"

      "$mod, comma, workspace, -1"
      "$mod, period, workspace, +1"

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"
      "$mod SHIFT, 0, movetoworkspace, 10"

      # Swap active window with the one next to it with mainMod + SHIFT + arrow keys
      "$mod SHIFT, left, swapwindow, l"
      "$mod SHIFT, right, swapwindow, r"
      "$mod SHIFT, up, swapwindow, u"
      "$mod SHIFT, down, swapwindow, d"

      # Resize active window
      "$mod, minus, resizeactive, -100 0"
      "$mod, equal, resizeactive, 100 0"
      "$mod SHIFT, minus, resizeactive, 0 -100"
      "$mod SHIFT, equal, resizeactive, 0 100"

      # Scroll through existing workspaces with mainMod + scroll
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"

      # Control Apple Display brightness
      "CTRL, F1, exec, ~/.local/share/omarchy/bin/apple-display-brightness -5000"
      "CTRL, F2, exec, ~/.local/share/omarchy/bin/apple-display-brightness +5000"
      "SHIFT CTRL, F2, exec, ~/.local/share/omarchy/bin/apple-display-brightness +60000"

      # $mod workspace floating layer
      "$mod, S, togglespecialworkspace, magic"
      "$mod SHIFT, S, movetoworkspace, special:magic"

      # Screenshots
      ", PRINT, exec, hyprshot -m region"
      "SHIFT, PRINT, exec, hyprshot -m window"
      "CTRL, PRINT, exec, hyprshot -m output"

      # Color picker
      "$mod, PRINT, exec, hyprpicker -a"

      # Clipse
      "CTRL $mod, V, exec, ghostty --class clipse -e clipse"
          ];
    bindm = [
      # Move/resize windows with mainMod + LMB/RMB and dragging
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    bindel = [
      # Laptop multimedia keys for volume and LCD brightness
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
      ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
      ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
    ];

    bindl = [
      # Requires playerctl
      ", XF86AudioNext, exec, playerctl next"
      ", XF86AudioPause, exec, playerctl play-pause"
      ", XF86AudioPlay, exec, playerctl play-pause"
      ", XF86AudioPrev, exec, playerctl previous"
    ];
    };
  };# enable Hyprland
home.stateVersion = "25.11";
home.packages = with pkgs;[ inputs.zen-browser.packages.${pkgs.system}.default];
}
