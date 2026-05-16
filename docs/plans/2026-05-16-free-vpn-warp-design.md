# Design Doc - Cloudflare WARP on NixOS

## Overview
This document outlines the implementation of a free VPN solution for the NixOS system using Cloudflare WARP. Cloudflare WARP is chosen for its performance, ease of use, and native support in NixOS via specialized modules.

## Architecture
The implementation utilizes the `cloudflare-warp` daemon (`warp-svc`) managed by systemd.

- **Service:** `services.cloudflare-warp.enable` handles the daemon lifecycle.
- **Client:** `cloudflare-warp` package provides the `warp-cli` for user interaction.
- **Protocol:** Uses WireGuard internally for secure and fast tunneling.

## Components

### 1. NixOS Module (`modules/vpn.nix`)
A dedicated module to isolate VPN configuration:
- Enables the `cloudflare-warp` service.
- Adds `pkgs.cloudflare-warp` to `environment.systemPackages`.

### 2. Configuration Integration
Update `configuration.nix` to import `./modules/vpn.nix`.

## Data Flow
1. **Request:** User initiates connection via `warp-cli connect`.
2. **Tunneling:** `warp-svc` establishes a WireGuard tunnel to the nearest Cloudflare edge node.
3. **Routing:** System traffic is routed through the `warp0` interface (or as configured by the daemon).

## Testing & Validation
1. **Daemon Status:** Check `systemctl status warp-svc`.
2. **Registration:** Verify registration with `warp-cli registration register`.
3. **Connectivity:**
   - Connect: `warp-cli connect`.
   - Status Check: `warp-cli status`.
   - IP Verification: `curl ifconfig.me` before and after connection.

## Rollback Plan
- Remove `./modules/vpn.nix` from `imports` in `configuration.nix`.
- Delete `modules/vpn.nix`.
- Rebuild the system.
