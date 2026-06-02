{ config, lib, pkgs, ... }:

{
  # Graphics: Enable the base graphics infrastructure (Mesa, VA-API).
  hardware.graphics = {
    enable = true;
    enable32Bit = true; # Required for Steam and 32-bit games.
    extraPackages = with pkgs; [
      nvidia-vaapi-driver # Video Acceleration API for NVIDIA (hardware video decoding).
      libva-utils         # Tools for verifying VA-API status.
    ];
  };

  # Driver: Force the X server to use the NVIDIA driver.
  services.xserver.videoDrivers = ["nvidia"];

  # NVIDIA Specific Settings
  hardware.nvidia = {
    # Modesetting: Required for Wayland (Hyprland) and high-resolution TTY.
    modesetting.enable = true;

    # Power Management: Experimental features that can sometimes cause suspend/resume issues.
    powerManagement.enable = false;
    powerManagement.finegrained = false; # Disabling for stability; fine-grained can turn off the GPU.

    # Open Source Modules: Using the proprietary modules for better feature support/performance on older/stable GPUs.
    open = false;

    # Settings Menu: Enable the 'nvidia-settings' GUI tool.
    nvidiaSettings = true;

    # Package: Use the 'stable' driver branch tied to the current kernel.
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # PRIME: Configure Hybrid Graphics (Intel iGPU + NVIDIA dGPU).
    prime = {
      # Sync Mode: The NVIDIA GPU handles all rendering, providing the best performance but using more battery.
      sync.enable = true;
      # Bus IDs: Unique hardware addresses found via 'lspci'.
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Environment: Variables to ensure apps use NVIDIA and Wayland correctly.
  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "nvidia";       # Hardware acceleration driver.
    GBM_BACKEND = "nvidia-drm";         # Generic Buffer Management for Wayland.
    __GLX_VENDOR_LIBRARY_NAME = "nvidia"; # Ensure OpenGL uses NVIDIA.
    NVD_BACKEND = "direct";             # Backend for the NVIDIA VA-API driver.
    
    # Browser: Allow hardware acceleration in Firefox on NVIDIA.
    MOZ_DISABLE_RDD_SANDBOX = "1";
    
    # Prime Offload: Ensure applications can access the NVIDIA GPU resources.
    __NV_PRIME_RENDER_OFFLOAD = "1";
    __NV_PRIME_RENDER_OFFLOAD_PROVIDER = "NVIDIA-G0";
    __VK_LAYER_NV_optimus = "NVIDIA_only"; # Force Vulkan to use NVIDIA.
  };
}
