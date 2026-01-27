{
  services = {
    audio = true;
    bluetooth = true;
    printing = true;
    displayManager = {
      sdm = false;
      greetd = true;
    };
    batteryManager = {
      tlp = true;
    };
    virtualization = {
      docker = true;
    };
  };

  shell = {
    fish = true;
    zsh = false;
    bash = true;
  };

  desktop = {
    hyprland = true;
    waybar = false;
    launcher = {
      wofi = false;
      rofi = true;
    };
    hypridle = true;
    hyprlock = true;
    notification = {
      swaync = false;
    };
  };

  terminal = {
    ghostty = true;
  };

  editor = {
    zed = true;
    vscode = true;
    intellij = true;
  };

  dev = {
    rust = true;
    java = false;
  };
}
