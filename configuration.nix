# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    (inputs.import-tree ./services)
  ];
  #Use official latest kernel
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages =
    let
      unstable = import inputs.nixpkgs-unstable {
        system = pkgs.stdenv.hostPlatform.system;
        config.allowUnfree = true;
      };
    in
    with pkgs;
    [
      wlogout
      glib
      gsettings-desktop-schemas
      polkit
      exfatprogs
      linuxHeaders
      asusctl
      dmidecode
    ];

  # programs.thunar = {
  #   enable = true;
  #   plugins = with pkgs.xfce; [
  #     thunar-archive-plugin
  #     thunar-volman
  #   ];
  # };
  system.stateVersion = "25.11"; # Define your hostname.
  services.asusd.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
    useNetworkd = true;

  };

  systemd.network.wait-online.enable = false;
  systemd.services = {
    NetworkManager-wait-online.enable = false;
    # use systemctl restart instead of a stop and a delayed start
    systemd-networkd.stopIfChanged = false;
    systemd-resolved.stopIfChanged = false;
  };
  environment.variables.QT_QPA_PLATFORM = "wayland";

  programs.fuse.userAllowOther = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      # Build optimization

      cores = 0;
      max-jobs = "auto";
      min-free = 128 * 1024 * 1024; # 128MB
      max-free = 1024 * 1024 * 1024; # 1GB

      # Binary caches
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://attic.xuyh0120.win/lantian"
        "https://cache.garnix.io"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
      ];
    };

    # Garbage collection
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 15d";
    };
  };
  # Bootloader (now configured in boot.nix module)
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    # Kernel
    kernelPackages = pkgs.linuxPackagesFor inputs.nix-cachyos-kernel.packages.${pkgs.stdenv.hostPlatform.system}.linux-cachyos-bore-lto;

    extraModulePackages = [ ];

    blacklistedKernelModules = [ ];
    kernelModules = [
      "asus-wmi"
      "asus-nb-wmi"
      "msr"
      "coretemp"
      "i2c-dev"
    ];

    extraModprobeConfig = "";

    plymouth = {
      enable = true;
      theme = "green_blocks";
      themePackages = with pkgs; [
        # By default we would install all themes
        (adi1090x-plymouth-themes.override {
          selected_themes = [ "green_blocks" ];
        })
      ];
    };

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "udev.log_level=3"
      "systemd.show_status=auto"
      "acpi_enforce_resources=lax"
      "nvme_load=YES"
      "nvidia-drm.modeset=1"
      "asus_wmi.fnlock_default=0"
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

  };

  zramSwap = {
    enable = true;
    priority = 100;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  services.fstrim.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  # services.thermald.enable = true;

  users.users.sagar = {
    isNormalUser = true;
    description = "Sagar Mishra";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "scanner"
      "lp"
    ];
  };
  environment.variables = {
    PATH = [ "~/.cargo/bin/" ];
    BINDGEN_EXTRA_CLANG_ARGS = "-I${pkgs.linuxHeaders}/include";
    # Nvidia Wayland Optimizations
    __GL_GSYNC_ALLOWED = "0";
    __GL_VRR_ALLOWED = "0";
    NVD_BACKEND = "direct";
    LIBVA_DRIVER_NAME = "nvidia";
  };
  nixpkgs.config.allowUnfree = true;
  environment.pathsToLink = [
    "/share/applications"
    "/share/xdg-desktop-portal"
  ];

  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.hplipWithPlugin ];

  # Enable the CUPS printing service with HP drivers
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  # Add your user to the 'scanner' and 'lp' groups to grant hardware access

  # Recommended for network-connected HP printers
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;
  services.avahi.openFirewall = true;

  # services.throttled = {
  #   enable = true;
  #   extraConfig = ''
  #     [GENERAL]
  #     Enabled: True
  #     Sysfs_Power_Path: /sys/class/power_supply/ACAD/online

  #     [AC]
  #     Update_Rate_s: 5
  #     PL1_TDP_W: 90
  #     PL1_Duration_s: 28
  #     PL2_TDP_W: 125
  #     PL2_Duration_S: 0.002
  #     Trip_Temp_C: 98
  #     cTDP: 2
  #     Disable_BDPROCHOT: True

  #     [BATTERY]
  #     Update_Rate_s: 30
  #     PL1_TDP_W: 40
  #     PL1_Duration_s: 28
  #     PL2_TDP_W: 50
  #     PL2_Duration_S: 0.002
  #     Trip_Temp_C: 85
  #     cTDP: 1
  #     Disable_BDPROCHOT: True

  #     [UNDERVOLT]
  #     # CPU core voltage offset (mV)
  #     CORE: -60
  #     # Integrated GPU voltage offset (mV)
  #     GPU: 0
  #     # CPU cache voltage offset (mV)
  #     CACHE: -60
  #     # System Agent voltage offset (mV)
  #     UNCORE: 0
  #     # Analog I/O voltage offset (mV)
  #     ANALOGIO: 0
  #   '';
  # };

  systemd.services.unlock-cpu-freq = {
    description = "Unlock CPU frequency scaling max";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.msr-tools}/bin/wrmsr -a 0x1FC 0x24005c && for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do echo performance > \"$i\"; done && for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq; do echo 5000000 > \"$i\"; done && echo 1 > /sys/devices/system/cpu/cpufreq/boost || true'";
      RemainAfterExit = true;
    };
  };
}
