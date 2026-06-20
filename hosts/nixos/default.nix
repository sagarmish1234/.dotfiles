{
  config,
  pkgs,
  inputs,
  ...
}: {
  # Apply NUR overlay
  nixpkgs.overlays = [
    inputs.nur.overlays.default
    (final: prev: {
      stdenv = prev.stdenv // {
        mkDerivation = args: prev.stdenv.mkDerivation (
          if (args.pname or "") == "fetch" then
            args // {
              postPatch = (args.postPatch or "") + ''
                substituteInPlace fetch.c \
                  --replace-fail "static int get_term_rows(void) {" "static int get_term_rows(void) { return 0; "
              '';
            }
          else
            args
        );
      };
    })
  ];

  # Imports: Modularly include system components.
  imports = [
    ./hardware.nix # Hardware scan results (CPU, Disks, GPU).
    ../../modules/core # Essential system settings (Locale, Nix, etc.).
    ../../modules/core/secrets.nix # Encrypted secrets (sops-nix).
    ../../modules/core/nvidia.nix # NVIDIA driver configuration.
    ../../modules/desktop # Desktop environment (Hyprland, SDDM).
    ../../users/sagar # User-specific system settings.
  ];

  # Networking: Hostname and basic tweaks.
  networking.hostName = "nixos";
  networking.networkmanager.wifi.powersave = true;
  # Optimization: Disable waiting for online status during boot to speed up startup.
  systemd.services.NetworkManager-wait-online.enable = false;

  # Bootloader: Using systemd-boot for EFI systems.
  boot.loader.systemd-boot.enable = true;
  # Keep only the last 10 generations in the boot menu to prevent clutter.
  boot.loader.systemd-boot.configurationLimit = 10;
  # Set timeout to 0 for instant boot; hold Shift during boot if you need the menu.
  boot.loader.timeout = 0;
  boot.loader.efi.canTouchEfiVariables = true;

  # Kernel: Use XanMod for improved desktop responsiveness and gaming performance.
  boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;

  # Modern initrd: Use systemd within the initial ramdisk for faster, more robust booting.
  boot.initrd.systemd.enable = true;
  # Compression: Zstandard provides a great balance between speed and compression ratio.
  boot.initrd.compressor = "zstd";
  boot.initrd.verbose = false;
  # Load NVIDIA modules early in the boot process to ensure Wayland (Niri) displays correctly and avoids a black screen
  boot.initrd.kernelModules = [
    "nvidia"
    "nvidia_modeset"
    "nvidia_uvm"
    "nvidia_drm"
  ];

  # Performance and Silence: Kernel parameters for a faster, cleaner boot.
  boot.kernelParams = [
    "quiet"
    "splash"
    "pcie_aspm=performance"
    "nvme_load=1"
    "fastboot"
    "nowatchdog"
    "nmi_watchdog=0"
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=1" # Enable Nvidia Framebuffer support for Wayland/SDDM rendering
    "8250.nr_uarts=0"
    "tpm_tis.interrupts=0"
    "tpm.disable=1"
    "module_blacklist=tpm,tpm_tis,tpm_crb"
    "rd.systemd.show_status=false"
    "rd.udev.log_level=3"
    "loglevel=3"
    "libahci.ignore_sss=1"
    "systemd.show_status=auto"
    "udev.log_priority=3"
    "pci=pcie_bus_perf"
  ];

  # Blacklist: Explicitly prevent these modules from ever being loaded.
  boot.blacklistedKernelModules = ["tpm" "tpm_tis" "tpm_crb"];

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  # State Version: The NixOS version the system was originally installed on.
  # NEVER change this unless you have read the release notes and handled migrations.
  system.stateVersion = "26.11";
}
