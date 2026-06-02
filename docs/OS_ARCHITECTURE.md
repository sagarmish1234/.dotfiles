# OS Architecture Documentation

This document explains the low-level design choices and configurations of this NixOS system. It is intended to be a complete reference for the "OS Level" plumbing.

---

## 1. Boot & Kernel
- **Kernel (`boot.kernelPackages`):** We use `linuxPackages_xanmod_latest`. XanMod is a kernel fork designed for desktop responsiveness, low latency, and better gaming performance. It includes patches like the MuQSS scheduler (or similar modern equivalents).
- **Bootloader (`boot.loader`):** Using `systemd-boot` (EFI). It is simpler and faster than GRUB for modern systems. `configurationLimit = 10` prevents the EFI partition from filling up with old versions.
- **Initial RAM Disk (initrd):** We enable `boot.initrd.systemd`. This brings the power of systemd units to the early boot phase, making it more robust and faster.
- **Kernel Parameters (`boot.kernelParams`):**
    - `quiet`, `splash`: Keeps the boot clean.
    - `pcie_aspm=performance`: Disables power saving on PCIe to prevent latency/stutter.
    - `nvme_load=1`: Loads NVMe drivers immediately.
    - `nowatchdog`: Disables the hardware watchdog (a "dead-man's switch") to save interrupts.
    - `module_blacklist=tpm...`: Disables TPM modules which can cause boot delays or stutter on some hardware.

---

## 2. Storage & Filesystem
- **Btrfs:** The system uses Btrfs across the main drive.
- **Subvolumes:** We split `/`, `/home`, and `/nix` into subvolumes. This allows:
    - **Compression (`zstd`):** Saves disk space and improves read speeds (less data to read from disk, decompressed by CPU).
    - **Atomic Snapshots:** (Future ready) for system rollbacks.
- **Optimization:** `noatime` prevents the OS from writing to the disk every time a file is *read*, significantly reducing disk wear and increasing speed.

---

## 3. Performance Engine
- **Memory (`zramSwap`):** Instead of a physical swap partition (slow disk), we use ZRAM. This creates a compressed RAM device for swap. It's much faster and prevents system "thrashing" when RAM is full.
- **Process Priority (`ananicy-cpp`):** Automatically "nices" (prioritizes) interactive applications (browsers, games, window managers) over background tasks.
- **Network (`sysctl`):**
    - `tcp_congestion_control = bbr`: A Google-developed algorithm that significantly improves throughput on modern networks.
    - `fq`: Fair Queuing scheduler required for BBR.
- **Thermal (`throttled`):** Overrides Intel's conservative power limits (PL1/PL2) to prevent the CPU from slowing down prematurely on battery or AC.

---

## 4. Graphics (NVIDIA)
- **PRIME Sync:** The system is set to `sync.enable = true`. This means the NVIDIA GPU handles all rendering for the primary display. 
    - *Pros:* No screen tearing, maximum performance. 
    - *Cons:* Higher battery consumption than "Offload" mode.
- **Modesetting:** Required for the Wayland protocol (Hyprland) to talk to the NVIDIA driver.

---

## 5. Security & Secrets
- **SOPS-nix:** Secrets (passwords, keys) are stored in an encrypted YAML file.
- **Age:** The decryption uses the `age` format. 
- **SSH Key Decryption:** The system is configured to use its own hardware-specific SSH Host Key (`/etc/ssh/ssh_host_ed25519_key`) to decrypt secrets at boot. This means the system can automatically mount encrypted services without user input.

---

## 6. Nix Pipeline
- **Flakes:** Ensures the entire system state is reproducible and pinned to specific versions in `flake.lock`.
- **Substituters (Binary Caches):** We use Cachix (Hyprland, Noctalia, etc.). Instead of your computer compiling complex software from source code, it downloads pre-built binaries from these trusted servers.
- **Auto-Optimise:** `auto-optimise-store = true` ensures that if two packages have the same file, Nix will "hard-link" them together, saving massive amounts of disk space.
