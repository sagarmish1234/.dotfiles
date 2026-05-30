{ config, lib, pkgs, ... }:

{
  # sched_ext (scx) for better desktop responsiveness (2026 standard)
  services.scx = {
    enable = true;
    scheduler = "scx_lavd";
    extraArgs = [ "--autopower" ];
  };

  # Memory Management: ZRAM and MGLRU
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };

  boot.kernel.sysctl = {
    # MGLRU and memory management
    "vm.swappiness" = 180; # Favor ZRAM over disk swap
    "vm.watermark_boost_factor" = 0;
    "vm.watermark_scale_factor" = 125;
    "vm.page-cluster" = 0;
    
    # TCP/Network optimizations
    "net.core.rmem_max" = 16777216;
    "net.core.wmem_max" = 16777216;
    "net.ipv4.tcp_rmem" = "4096 87380 16777216";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "fq";
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_slow_start_after_idle" = 0;
    "net.ipv4.tcp_mtu_probing" = 1;
  };

  # Process prioritization
  services.ananicy = {
    enable = true;
    package = pkgs.ananicy-cpp;
    rulesProvider = pkgs.ananicy-rules-cachyos;
  };

  # GameMode for high-performance bursts
  programs.gamemode.enable = true;

  # Store optimization
  nix.settings = {
    auto-optimise-store = true;
    min-free = 128000000; # 128MB
    max-free = 1000000000; # 1GB
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };

  # SSD optimization
  services.fstrim.enable = true;

  # OOM Killer
  services.earlyoom = {
    enable = true;
    freeMemThreshold = 5;
    freeSwapThreshold = 5;
  };

  # Performance governor settings via TLP (already enabled, but let's ensure performance on AC)
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    
    # Enable SATA Aggressive Link Power Management
    SATA_ALPM_ENABLE_ON_AC = "max_performance";
    SATA_ALPM_ENABLE_ON_BAT = "med_power_with_dipm";
    
    # PCIE ASPM
    PCIE_ASPM_ON_AC = "performance";
    PCIE_ASPM_ON_BAT = "powersave";
  };

  # I/O Scheduler
  services.udev.extraRules = ''
    # set scheduler for NVMe
    ACTION=="add|change", KERNEL=="nvme[0-9]n[0-9]", ATTR{queue/scheduler}="kyber"
    # set scheduler for SSD and eMMC
    ACTION=="add|change", KERNEL=="sd[a-z]|mmcblk[0-9]*", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="bfq"
    # set scheduler for HDD
    ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="bfq"
  '';
}
