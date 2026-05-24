# Project Overview: Sagar's NixOS Dotfiles

This repository contains a modular and highly customized NixOS configuration managed via **Nix Flakes** and **Home Manager**. It provides a cohesive desktop experience centered around **Hyprland** and a custom shell UI component named **Noctalia**.

## Architecture

The project follows a modular structure where features can be easily toggled and configurations are separated by scope:

*   **`flake.nix`**: The central entry point. It manages external dependencies (inputs) and defines the `nixos` system configuration.
*   **`feature.nix`**: A centralized "toggle" file used to enable or disable specific services, desktop components, editors, and development environments across the entire configuration.
*   **`configuration.nix`**: The core NixOS system configuration. It handles hardware, bootloader, networking, and system-level services. It imports modular services from the `./services` directory.
*   **`home.nix`**: The primary Home Manager configuration. It manages user-specific applications, dotfiles, and desktop settings. It imports modular components from the `./modules` directory.
*   **`modules/`**: Contains user-level Home Manager modules (e.g., `hyprland`, `waybar`, `git`, `theme`, and various application configs).
*   **`services/`**: Contains system-level NixOS service modules (e.g., `nvidia`, `docker`, `audio`, `tlp`).
*   **`bin/`**: Custom utility scripts defined as Nix expressions (`pkgs.writeShellApplication`).
*   **`config/`**: Directory for application-specific configuration files and sub-projects (e.g., `noctalia-shell`).
*   **`assets/`**: Local assets like wallpapers.

## Key Technologies

*   **OS/Package Manager**: NixOS, Nix Flakes, Home Manager.
*   **Window Manager**: Hyprland (Wayland).
*   **Shell UI**: Noctalia Shell (custom implementation).
*   **Theming**: Stylix (consistent theming across apps).
*   **Development**: Support for Rust, Java, Python, Go, and JavaScript via `direnv` and Nix shells.
*   **Hardware Support**: Optimized for Asus laptops with Nvidia graphics (`asusd`, `supergfxd`).

## Building and Management

To apply changes to the system and user configuration:

```bash
# Apply changes (rebuild and switch)
sudo nixos-rebuild switch --flake .#nixos

# Update all flake inputs
nix flake update

# Garbage collection (clean up old generations)
nix-collect-garbage -d
```

## Development Conventions

*   **Feature Toggles**: When adding a new module or service, add a corresponding toggle in `feature.nix` and use `lib.mkIf feature.category.name` to guard its implementation.
*   **Modularity**: Prefer small, focused Nix files over large monolithic ones. Use `import-tree` to automatically include modules from the `modules/` and `services/` directories.
*   **Surgical Edits**: When modifying existing configurations, maintain the established style of using function arguments (e.g., `{ pkgs, lib, inputs, feature, ... }`).
*   **On-Demand Mounting**: For cloud storage like Google Drive, prefer on-demand mounting via application wrappers rather than global systemd services. Use `pkgs.symlinkJoin` to override the application binary while preserving its desktop metadata and icons.
*   **Theming**: Use the `stylix` options where possible to ensure visual consistency across the system.

## Troubleshooting & Known Fixes

### Rclone Google Drive Mounting
*   **Permission Issues**: Always use `/run/wrappers/bin/fusermount3` instead of the Nix store path to ensure SUID permissions for FUSE mounts.
*   **Launcher Visibility**: When wrapping applications (like Yazi), ensure you use `pkgs.symlinkJoin` to include the original package's `share/` directory, otherwise the application will disappear from graphical launchers (Noctalia, etc.).
