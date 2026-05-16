{
  services = {
    audio = true;
    bluetooth = true;
    printing = true;
    displayManager = {
      sdm = false;
      greetd = false;
    };
    batteryManager = {
      tlp = true;
    };
    virtualization = {
      docker = false;
      podman = true;
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
      rofi = false;
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
    zed = false;
    vscode = true;
    intellij = true;
    nvim = true;
    emacs = true;
  };

  dev = {
    rust = true;
    java = true;
    python = true;
    go = false;
    javascript = true;
  };
}
