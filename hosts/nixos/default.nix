{ config, pkgs, ... }:

{
  # Imports: Modularly include system components.
  imports = [
    ./hardware.nix             # Hardware scan results (CPU, Disks, GPU).
    ../../modules/core         # Essential system settings (Locale, Nix, etc.).
    ../../modules/core/secrets.nix # Encrypted secrets (sops-nix).
    ../../modules/core/nvidia.nix  # NVIDIA driver configuration.
    ../../modules/desktop      # Desktop environment (Hyprland, SDDM).
    ../../users/sagar          # User-specific system settings.
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
  boot.initrd.kernelModules = [ ]; # Minimal modules for faster initrd phase.

  # Performance and Silence: Kernel parameters for a faster, cleaner boot.
  boot.kernelParams = [
    "quiet"                   # Suppress non-critical kernel messages.
    "splash"                  # Enable boot splash (if a theme is present).
    "pcie_aspm=performance"   # Force PCIe Active State Power Management to performance.
    "nvme_load=1"             # Ensure NVMe drivers are loaded early.
    "fastboot"                # Skip certain hardware checks during boot.
    "nowatchdog"              # Disable hardware watchdog to free up resources.
    "nmi_watchdog=0"          # Disable NMI watchdog (reduces interrupts).
    "nvidia-drm.modeset=1"    # Enable Kernel Mode Setting for NVIDIA (required for Wayland).
    "8250.nr_uarts=0"         # Disable legacy serial ports to speed up initialization.
    "tpm_tis.interrupts=0"    # Avoid TPM interrupt issues on certain hardware.
    "tpm.disable=1"           # Disable TPM entirely for speed/simplicity if not needed.
    "module_blacklist=tpm,tpm_tis,tpm_crb" # Prevent TPM modules from loading.
    "rd.systemd.show_status=false" # Hide systemd status messages in initrd.
    "rd.udev.log_level=3"     # Reduce udev logging in initrd.
    "loglevel=3"              # Only show errors and warnings.
    "libahci.ignore_sss=1"    # Ignore Staggered Spin-Up (speeds up SATA detection).
    "systemd.show_status=auto" # Only show systemd status if there is an error.
    "udev.log_priority=3"     # Reduce udev logging priority.
    "pci=pcie_bus_perf"       # Optimize PCI Express bus performance.
  ];

  # Blacklist: Explicitly prevent these modules from ever being loaded.
  boot.blacklistedKernelModules = [ "tpm" "tpm_tis" "tpm_crb" ];

  # State Version: The NixOS version the system was originally installed on.
  # NEVER change this unless you have read the release notes and handled migrations.
  system.stateVersion = "26.05";
}
