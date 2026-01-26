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
    waybar = true;
    launcher = {
      wofi = false;
      rofi = true;
    };
    hypridle = true;
    hyprlock = true;
    notification = {
      swaync = true;
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
