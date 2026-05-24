# Migration Plan: NixOS Stable to Unstable

## Overview
Migrate Sagar's NixOS dotfiles from NixOS 25.11 (Stable) to NixOS Unstable using a phased approach to minimize downtime and regressions.

## Strategy: The "Reverse Shim"
Modules are incrementally updated to use the `unstable` argument passed from `flake.nix`. Once all modules are transitioned, the primary `nixpkgs` input will be pointed to unstable.

## Phases

### Phase 1: Development Environments & Tools (ACTIVE)
- **Scope**: Upgrading high-velocity dev tools and editors.
- **Targets**:
  - `modules/dev/*` (Rust, Java, Python, Go, JS)
  - `modules/editors/*` (NVF/Nvim, VSCode, Emacs, Zed)
  - `modules/ghostty.nix`
- **Status**: In Progress

### Phase 2: Browser & User Applications
- **Scope**: Daily driver applications.
- **Targets**:
  - `modules/browsers/*` (Zen, Firefox)
  - `modules/webapps/*`
  - `modules/packages.nix`
- **Status**: Pending

### Phase 3: Desktop Environment
- **Scope**: Hyprland ecosystem and UI.
- **Targets**:
  - `modules/hyprland/`
  - `modules/noctalia.nix`
  - `modules/ags.nix`
  - `modules/waybar.nix`
  - `modules/theme/`
- **Status**: Pending

### Phase 4: Core System & Infrastructure
- **Scope**: Kernel, Drivers, and System Services.
- **Targets**:
  - `services/*`
  - `flake.nix` (Global input switch)
- **Status**: Pending

## Hand-off Protocol
Each phase must provide:
1. Summary of changes.
2. Verification commands.
3. Rollback instructions.
