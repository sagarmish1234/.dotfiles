{ config, pkgs, ... }:

{
  # Imports: Modular desktop components.
  imports = [
    ./niri.nix
    ./sddm.nix
    # ./gnome.nix
  ];

  # X11: Enable the X Window System. 
  # Even on Wayland, this is often required for certain drivers and compatibility layers (XWayland).
  services.xserver.enable = true;

  # Keyboard: Default US layout for the X server.
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Printing: Disabled by default to save resources. Enable CUPS if needed.
  services.printing.enable = false;

  # Audio: Using Pipewire, the modern replacement for PulseAudio and JACK.
  # PulseAudio is explicitly disabled to avoid conflicts.
  services.pulseaudio.enable = false;
  
  # Real-time Priority: rtkit is required for Pipewire to acquire real-time scheduling.
  security.rtkit.enable = true;
  
  services.pipewire = {
    enable = true;
    alsa.enable = true;           # ALSA compatibility.
    alsa.support32Bit = true;      # 32-bit ALSA (required for some games).
    pulse.enable = true;          # PulseAudio compatibility.
  };
}
