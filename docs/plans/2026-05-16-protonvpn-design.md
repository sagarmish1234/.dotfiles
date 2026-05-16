# Design Doc - ProtonVPN on NixOS

## Overview
This document outlines the implementation of ProtonVPN on the NixOS system to allow for region-switching capabilities. This complements the existing Cloudflare WARP setup.

## Architecture
ProtonVPN will be integrated as an optional service module, following the project's feature flag pattern.

- **Client:** `protonvpn-cli` package provides the command-line interface for connection management.
- **Protocol:** Uses OpenVPN or WireGuard (managed by the CLI tool).
- **Toggle:** Controlled via `feature.services.protonvpn` in `feature.nix`.

## Components

### 1. Feature Flag (`feature.nix`)
Add `protonvpn = true;` to the `services` attribute set.

### 2. Service Module (`services/protonvpn.nix`)
- Conditionally adds `pkgs.protonvpn-cli` to `environment.systemPackages` using `lib.mkIf`.

## Usage & Workflow
1. **Preparation:** Ensure Cloudflare WARP is disconnected (`warp-cli disconnect`).
2. **Login:** `protonvpn-cli login <username>`.
3. **Connection:** `protonvpn-cli connect --fastest` or `protonvpn-cli c`.
4. **Verification:** `curl ipinfo.io` to check the new country.

## Constraints
- **Mutual Exclusion:** WARP and ProtonVPN should not be active simultaneously to avoid routing conflicts.

## Testing & Validation
1. **Package Availability:** Verify `protonvpn-cli` is in the PATH after rebuild.
2. **Login Flow:** Verify the CLI can initiate the login sequence.
3. **Connection:** Verify a successful connection to a non-local region.
