{
  config,
  pkgs,
  ...
}: {
  # Imports: System-wide modules for specific hardware or services.
  imports = [
    ./tlp.nix # Battery optimization and power management.
    ./performance.nix # Performance tweaks (CPU governor, etc.).
    ./torrent.nix # Torrent daemon and TUI clients.
    ./nh.nix # Nix Helper (nh) and rebuild utilities.
  ];

  # Time Zone: Set to Kolkata for Indian Standard Time.
  time.timeZone = "Asia/Kolkata";

  # Locale: Set the primary language to US English.
  i18n.defaultLocale = "en_US.UTF-8";

  # Regional Settings: Use Indian formats for currency, measurements, etc.
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

  # Unfree Packages: Allow non-open-source software (like NVIDIA drivers, Discord, etc.).
  nixpkgs.config.allowUnfree = true;

  # Essential System Packages: Critical tools available to all users.
  environment.systemPackages = with pkgs; [
    git # Version control.
    vim # Text editor.
    wget # File downloader.
    fish # Modern interactive shell.
    psmisc # Process management tools (killall, pstree).
    linuxPackages.cpupower # Tool to manage CPU power settings.
  ];

  # Nix Settings: Configure the behavior of the Nix package manager.
  nix.settings = {
    # Flakes: Enable modern Nix commands and experimental flake support.
    experimental-features = ["nix-command" "flakes"];

    # Binary Caches: Pre-built package repositories to avoid local compilation.
    substituters = [
      "https://cache.nixos.org" # Official NixOS cache.
      "https://nix-community.cachix.org" # Community-maintained packages.
      "https://hyprland.cachix.org" # Optimized Hyprland builds.
      "https://noctalia.cachix.org" # Pre-built Noctalia shell packages.
      "https://cache.garnix.io" # Continuous integration cache for many flakes.
    ];

    # Public Keys: Security keys used to verify packages from the caches above.
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  # Networking: Enable NetworkManager for Wi-Fi and Ethernet management.
  networking.networkmanager.enable = true;

  # Hardware Support:
  # Bluetooth: Enable the service and keep it powered off by default to save battery.
  hardware.bluetooth.enable = true;
  hardware.bluetooth.powerOnBoot = false;
  # Power: Enable UPower for battery/charging status integration in the shell.
  services.upower.enable = true;

  # Shell: Set Fish as the default interactive shell.
  programs.fish.enable = true;
  environment.shells = with pkgs; [fish];

  # Fonts: System-wide font availability.
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono # Used for the UI, terminal, and shell.
    nerd-fonts.iosevka
  ];

  # Security:
  # PAM: Configure PAM to allow hyprlock to authenticate the user.
  security.pam.services.hyprlock = {};
}
