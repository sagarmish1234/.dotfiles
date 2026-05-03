{ lib, feature, ... }:
lib.mkIf feature.services.batteryManager.tlp {
  # TLP battery management
  services.tlp = {
    enable = true;
    settings = {
      # CPU Scaling Governor
      CPU_SCALING_GOVERNOR_ON_AC = "performance"; # When plugged in
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave"; # On battery

      # Battery Charge Thresholds (for long-term health)
      START_CHARGE_THRESH_BAT0 = 80; # Start charging when below 40%
      STOP_CHARGE_THRESH_BAT0 = 80; # Stop charging at 80%

      START_CHARGE_THRESH_BAT1 = 80;
      STOP_CHARGE_THRESH_BAT1 = 80;
      # Other common settings
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_performance";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 1; # Enable CPU boost on battery
      CPU_SCALING_MAX_FREQ_ON_AC = 5000000;
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 100;
      USB_AUTOSUSPEND = 1; # Enable USB autosuspend
    };
  };
}
