{
  services = {
    audio = true;
    bluetooth = true;
    printing = true;
    displayManager = {
      sdm = true;
      greetd = false;
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
    wofi = true;
  };

  launcher = {
    walker = false;
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
