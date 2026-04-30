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
  #Use Cachyos kernel
  nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
  programs.gdk-pixbuf.modulePackages = [ pkgs.librsvg ];

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    wlogout
    glib
    gsettings-desktop-schemas
    polkit
    exfatprogs
    linuxHeaders
    asusctl
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

      # Binary caches
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://hyprland.cachix.org"
        "https://attic.xuyh0120.win/lantian"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
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
    # kernelPackages = pkgs.linuxKernel.packagesFor pkgs.cachyosKernels.linux-cachyos-latest;
    # Kernel
    kernelPackages = pkgs.linuxPackages_6_18;

    blacklistedKernelModules = [ ];
    kernelModules = [ "asus-wmi" "asus-nb-wmi" ];

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
    ];
    # Hide the OS choice for bootloaders.
    # It's still possible to open the bootloader list by pressing any key
    # It will just not appear on screen unless a key is pressed
    loader.timeout = 0;

  };

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
  services.thermald.enable = true;

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
}
