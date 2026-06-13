# 🌌 Sagar's NixOS Dotfiles

[![NixOS](https://img.shields.io/badge/NixOS-26.05-blue.svg?logo=nixos&logoColor=white)](https://nixos.org)
[![Window Manager](https://img.shields.io/badge/WM-Niri-purple.svg?logo=wayland)](https://github.com/YaLTeR/niri)
[![Shell](https://img.shields.io/badge/Shell-Fish-cyan.svg)](https://fishshell.com)
[![Desktop Shell](https://img.shields.io/badge/Shell-Noctalia--Shell%20v5-magenta.svg)](https://github.com/noctalia-dev/noctalia-shell)
[![Theme](https://img.shields.io/badge/Theme-Tokyo--Night-blue.svg)](https://github.com/folke/tokyonight.nvim)

Welcome to my modular **NixOS** configuration powered by **Nix Flakes** and **Home Manager**. This configuration is optimized for responsiveness, modern aesthetics, and daily productivity, featuring the **Niri** scroll-tiling window compositor and **Noctalia-Shell v5**.

---

## 📸 Desktop Preview & Theme
- **Compositor:** [Niri](https://github.com/YaLTeR/niri) (Scroll-based tiling window manager)
- **Desktop Shell/Widgets:** [Noctalia-Shell v5](https://github.com/noctalia-dev/noctalia-shell)
- **Theme:** Tokyo-Night (Dark)
- **Terminal Emulator:** [Ghostty](https://ghostty.org/) (JetBrainsMono Nerd Font, 80% opacity, borderless)
- **Shell Prompt:** [Starship](https://starship.rs/) (integrated with Fish shell)

---

## 🏗️ System Architecture & Modularity

The repository follows a clean, modular multi-host layout:

```directory
.
├── flake.nix                  # Entry point for the system and Home Manager definitions
├── flake.lock                 # Pinned dependency locks
├── facter.json                # Hardware profile report for nixos-facter
├── GEMINI.md                  # Development guidelines and package rules
├── docs/                      # Architectural design decisions and system plans
│   └── OS_ARCHITECTURE.md     # In-depth plumbing (Kernel, Sysctl, Disk) details
├── hosts/                     # Machine configurations
│   └── nixos/                 # Host config for 'nixos'
│       ├── default.nix        # System-level entry point
│       └── hardware.nix       # Disks & CPU configuration
├── modules/                   # Shared system modules
│   ├── core/                  # Core OS features
│   │   ├── default.nix        # System basics (time, locale, caches)
│   │   ├── performance.nix    # Kernel & RAM optimizations
│   │   ├── nvidia.nix         # NVIDIA proprietary drivers & PRIME setup
│   │   ├── secrets.nix        # sops-nix secure environment hooks
│   │   ├── tlp.nix            # Advanced power management settings
│   │   └── torrent.nix        # System-wide Transmission daemon config
│   └── desktop/               # Desktop services
│       ├── default.nix        # Audio (Pipewire), X11, and basic services
│       ├── niri.nix           # Niri display manager integration & portals
│       └── sddm.nix           # SDDM (Astronaut theme + pixel_sakura subtheme)
└── users/                     # User configs
    └── sagar/                 # Sagar's home directory config
        ├── default.nix        # User properties & global user-packages
        ├── home.nix           # Home Manager entry point
        └── programs/          # Custom user-level configuration modules
```

---

## ⚡ Performance & Low-Latency Engines

This configuration contains low-level Linux performance tuning (see [OS_ARCHITECTURE.md](file:///home/sagar/.dotfiles/docs/OS_ARCHITECTURE.md) for more details):

*   **XanMod Kernel (`linuxPackages_xanmod_latest`):** High-performance desktop kernel featuring advanced scheduling and optimizations.
*   **Throttled CPU Management:** Bypasses Intel's aggressive thermal limiting policies, unlocking standard power boundaries on AC (`PL1: 90W`, `PL2: 135W`) and battery (`PL1: 65W`, `PL2: 80W`).
*   **ZRAM Swap & Swappiness:** Zstandard-compressed ZRAM swap partition using 50% of system RAM. Set to `vm.swappiness = 180` to keep application state in memory longer.
*   **BBR Network Congestion Control:** Google's BBR congestion control algorithm enabled with the Fair Queuing (`fq`) packet scheduler for ultra-low latency connections.
*   **Earlyoom OOM Killer:** Prevents hard locks by terminating processes before the system runs out of swap space or RAM (triggers at 5% free).
*   **Ananicy-cpp Scheduler:** Automatically assigns high priority to active graphical applications, browsers, and audio services.
*   **Kyber & BFQ I/O Schedulers:** Configured dynamically via udev rules for NVMe (`kyber`) and SATA SSD/HDD (`bfq`) drives to minimize disk latency.
*   **GameMode:** Enabled system-wide to maximize CPU/GPU priority on launching games.

---

## 🎮 Graphics & Video Acceleration (NVIDIA)

*   **PRIME Sync:** Hybrid configuration configured specifically for Intel iGPU + NVIDIA dGPU. Prime Sync is enabled, forcing the NVIDIA card to render the primary display for stutter-free Wayland.
*   **Hardware Video Acceleration:** NVIDIA VA-API (`nvidia-vaapi-driver`) configured to enable GPU decoding in applications like Firefox and MPV.
*   **Wayland Modesetting:** Early-loading kernel modules (`nvidia`, `nvidia_modeset`, `nvidia_uvm`, `nvidia_drm`) in `initrd` to support Wayland without login screens blinking or displaying black output.

---

## 🔒 Secrets Management

*   **SOPS-Nix Integration:** Secure storage of passwords, tokens, and keys in encrypted `secrets/secrets.yaml`.
*   **Automatic Decryption:** Cryptographic keys are decrypted using the system's hardware-based SSH Host Key (`/etc/ssh/ssh_host_ed25519_key`) during the early stage of system boot.

---

## 🛠️ Applications & Packages

The user configuration manages key applications and utilities modularly:

| Category | Component / Tool | Configuration File |
| :--- | :--- | :--- |
| **Compositor** | Niri | [niri.nix](file:///home/sagar/.dotfiles/users/sagar/programs/niri.nix) |
| **Launcher** | Fuzzel | [fuzzel.nix](file:///home/sagar/.dotfiles/users/sagar/programs/fuzzel.nix) |
| **Desktop Shell**| Noctalia Shell v5 | [noctaliaV5.nix](file:///home/sagar/.dotfiles/users/sagar/programs/noctaliaV5.nix) |
| **Terminal** | Ghostty | [home.nix](file:///home/sagar/.dotfiles/users/sagar/home.nix#L61-L93) |
| **Shell** | Fish + Starship | [home.nix](file:///home/sagar/.dotfiles/users/sagar/home.nix#L106-L182) |
| **Editor** | Neovim (`nvf`) & Zed | [neovim.nix](file:///home/sagar/.dotfiles/users/sagar/programs/neovim.nix), [zed.nix](file:///home/sagar/.dotfiles/users/sagar/programs/zed.nix) |
| **Browsers** | Firefox & Zen | [default.nix](file:///home/sagar/.dotfiles/users/sagar/default.nix#L3-L29), [zen.nix](file:///home/sagar/.dotfiles/users/sagar/programs/zen.nix) |
| **File Manager** | Yazi & Dolphin | [yazi.nix](file:///home/sagar/.dotfiles/users/sagar/programs/yazi.nix), [dolphin.nix](file:///home/sagar/.dotfiles/users/sagar/programs/dolphin.nix) |
| **Media Player** | MPV | [mpv.nix](file:///home/sagar/.dotfiles/users/sagar/programs/mpv.nix) |
| **Lockscreen** | Hyprlock & Hypridle | [hyprlock.nix](file:///home/sagar/.dotfiles/users/sagar/programs/hyprlock.nix), [hypridle.nix](file:///home/sagar/.dotfiles/users/sagar/programs/hypridle.nix) |

*Browsers are provisioned with custom policies injecting pre-configured security extensions (uBlock Origin, Bitwarden, ClearURLs, SponsorBlock, and Browsec VPN).*

---

## 🚀 Key Commands

### Rebuilding & Testing
Always execute these commands from the root of the dotfiles repository:

```bash
# Apply new configuration and switch active system profile
sudo nixos-rebuild switch --flake .#nixos

# Test the configuration instantly (non-persistent, does not create boot menu entries)
sudo nixos-rebuild test --flake .#nixos

# Test system activation dry run (see what changes)
sudo nixos-rebuild dry-activate --flake .#nixos

# Check flake syntax and errors
nix flake check

# Update dependencies pins (updates flake.lock)
nix flake update
```

### Secrets Management
```bash
# Decrypt and edit secrets.yaml interactively
sops secrets/secrets.yaml
```

---

## 📌 Rules for Adding Packages

To maintain modularity and flake purity, please follow these guidelines:
1.  **System-wide Essentials:** Critical system CLI tools go in `modules/core/default.nix` under `environment.systemPackages` (e.g. `git`, `vim`).
2.  **User-specific Applications:** Add general GUI/CLI utilities to `users/sagar/home.nix` under `home.packages`.
3.  **Dedicated Configs:** If a program has configuration options, write a modular configuration file under `users/sagar/programs/` (e.g. `yazi.nix`) and import it in `home.nix`.
4.  **Git Awareness:** Because Nix Flakes operate in a strict Git mode, **any new configuration files must be staged with `git add`** before running `nixos-rebuild`. Otherwise, Nix will treat the files as non-existent.
