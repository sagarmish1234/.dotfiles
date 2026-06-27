{ config, lib, pkgs, ... }:

{
  # Sched-ext (scx): Modern BPF-based CPU schedulers for the Linux kernel.
  # These can significantly improve desktop responsiveness under load.
  services.scx = {
    enable = false; # Disabled by default; enable if using a kernel that supports it (like XanMod/Cachy).
    scheduler = "scx_lavd"; # LAVD is designed for latency-sensitive desktop workloads.
  };

  # Thermal Management: Fixes throttling issues on Intel CPUs by adjusting PL1/PL2 power limits.
  services.thermald.enable = false; # Often conflicts with 'throttled'.
  services.throttled = {
    enable = true;
    extraConfig = ''
      [GENERAL]
      Enabled: True
      Sysfs_Power_Path: /sys/class/power_supply/AC*/online
      Autoreload: True

      [BATTERY]
      Update_Rate_s: 30
      # Sustained power limit on battery (increased from 45)
      PL1_Tdp_W: 65
      PL1_Duration_s: 28
      # Burst power limit on battery (increased from 65)
      PL2_Tdp_W: 80
      PL2_Duration_S: 0.002
      # Throttling temperature on battery
      Trip_Temp_C: 90
      # Prevent CPU from throttling due to external signals (like battery heat)
      Disable_BDPROCHOT: True

      [AC]
      Update_Rate_s: 1
      # Higher sustained power when plugged in (increased from 65)
      PL1_Tdp_W: 90
      PL1_Duration_s: 28
      # Higher burst power when plugged in (increased from 90)
      PL2_Tdp_W: 135
      PL2_Duration_S: 0.002
      # Allow higher temperatures on AC
      Trip_Temp_C: 95
      # Enable Intel Hardware P-States
      HWP_Mode: True
      Disable_BDPROCHOT: True
    '';
  };

  # Memory Management: ZRAM (Compressed RAM swap).
  zramSwap = {
    enable = true;
    algorithm = "zstd"; # Zstandard offers excellent compression/speed ratio.
    memoryPercent = 50; # Use up to 50% of RAM as compressed swap space.
  };

  # Kernel Runtime Parameters (sysctl): Low-level system tuning.
  boot.kernel.sysctl = {
    # Memory: Favor ZRAM swap (swappiness=180) to keep apps in memory longer.
    "vm.swappiness" = 180;
    "vm.watermark_boost_factor" = 0;   # Reduce background memory reclaiming.
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;             # Disable multi-page swap-in (good for SSD/ZRAM).
    
    # Network: Optimize for high-speed, low-latency connections.
    "net.core.rmem_max" = 16777216;    # Increase max receive buffer size.
    "net.core.wmem_max" = 16777216;    # Increase max send buffer size.
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.tcp_congestion_control" = "bbr"; # Use Google's BBR for better throughput.
    "net.core.default_qdisc" = "fq";            # Fair Queuing for BBR.
    "net.ipv4.tcp_fastopen" = 3;                # Speed up TCP handshakes.
    "net.ipv4.tcp_slow_start_after_idle" = 0;   # Don't restart slow start after idle.
    "net.ipv4.tcp_mtu_probing" = 1;             # Automatically detect the best MTU.
  };

  # Ananicy: Auto-Nice daemon. Automatically sets process priorities based on rules.
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp; # Faster C++ implementation.
    rulesProvider = pkgs.ananicy-rules-cachyos; # Excellent community rules for desktop/gaming.
  };

  # GameMode: System-level optimizations (governor, priority) for games.
  programs.gamemode.enable = true;

  # Nix Store: Optimize storage by hard-linking identical files.
  nix.settings = {
    auto-optimise-store = true;
    min-free = 128000000;  # Keep at least 128MB free.
    max-free = 1000000000; # Clean up until 1GB is free.
  };

  # Garbage Collection: Disable Nix's automatic gc in favor of nh's clean functionality.
  nix.gc = {
    automatic = false;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # SSD: Periodic TRIM to maintain performance and lifespan.
  services.fstrim.enable = true;

  # OOM Killer: Earlyoom kills processes before the system hangs due to memory exhaustion.
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;  # Kill at 5% free memory.
    freeSwapThreshold = 5; # Kill at 5% free swap.
  };

  # TLP Tweaks: Performance-specific overrides for TLP.
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    
    # SATA Power Management
    SATA_ALPM_ENABLE_ON_AC = "max_performance";
    SATA_ALPM_ENABLE_ON_BAT = "med_power_with_dipm";
    
    # PCIe ASPM
    PCIE_ASPM_ON_AC = "performance";
    PCIE_ASPM_ON_BAT = "powersave";
  };

  # I/O Schedulers: Set the best algorithm for different storage types.
  services.udev.extraRules = ''
    # NVMe: Use 'kyber' for low latency.
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="kyber"
    # SSD: Use 'bfq' (Budget Fair Queuing) for smoothness.
    ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    # HDD: Use 'bfq' to manage large rotational latency.
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
  '';
}
