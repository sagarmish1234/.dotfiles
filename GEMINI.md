# NixOS Dotfiles Configuration

> [!IMPORTANT]
> **MANDATE:** All information contained in this file or known by the model about NixOS and Flakes may be outdated. You MUST always search the internet for the latest recommendations, best practices, and official documentation before proposing or making changes.

This project manages a NixOS system configuration using Nix Flakes with a modular architecture. It is designed for maintainability and scalability, allowing for easy addition of new hosts, users, and features.

> [!WARNING]
> **GIT AWARENESS:** Because this project is a Git repository, Nix Flakes operate in "strict mode." **Any new file you create MUST be added to the Git index (e.g., `git add .`) before Nix can see it.** If you get a "file not found" error for a file that clearly exists, it is likely because it hasn't been added to Git.

## Project Overview

- **Main Technologies:** Nix, NixOS, Nix Flakes, Home Manager, sops-nix.
- **Architecture:** Modular Multi-host with centralized secrets management.
    - `hosts/`: Machine-specific configurations (e.g., hardware definitions, hostnames).
    - `modules/core/`: Essential system-wide settings (locale, networking, drivers).
    - `modules/desktop/`: Desktop environment and display manager setup.
    - `users/sagar/`: User-level system settings and Home Manager configuration.
    - `users/sagar/programs/`: Modular Home Manager program configurations (Hyprland, Ghostty, etc.).
    - `secrets/`: Encrypted secrets managed by `sops-nix`.

## Structure

- `/flake.nix`: Entry point for the flake configuration, defining inputs and mapping host/user configs.
- `/docs/OS_ARCHITECTURE.md`: Deep dive into low-level OS design choices (Kernel, Performance, Hardware).
- `/hosts/nixos/`: Configuration for the main `nixos` host.
    - `default.nix`: Host-specific entry point, imports core and desktop modules.
    - `hardware.nix`: Hardware scan results.
- `/modules/core/`: Essential system settings.
    - `default.nix`: Locale, time, networking, experimental features, fonts.
    - `secrets.nix`: `sops-nix` configuration.
    - `nvidia.nix`: NVIDIA driver and compatibility settings.
- `/modules/desktop/`: Desktop environment configuration.
    - `default.nix`: Common desktop services (X11, Printing, Pipewire).
    - `hyprland.nix`: System-level Hyprland setup.
    - `sddm.nix`: SDDM display manager with custom themes.
- `/users/sagar/`: Configuration for the user `sagar`.
    - `default.nix`: System-level user settings (shell, default packages).
    - `home.nix`: Home Manager entry point, imports program-specific modules.
    - `programs/`: Individual `.nix` files for each managed application (e.g., `hyprland.nix`, `noctalia.nix`, `yazi.nix`).
- `/secrets/secrets.yaml`: Encrypted secrets file.
- `/docs/plans/`: System migration and feature planning documents.
    - `2026-05-24-nixos-unstable-migration.md`: Phased migration plan from NixOS stable to unstable.
    - `2026-05-17-xonsh-migration-design.md`: Design document for transitioning from Fish shell to Xonsh.
    - `2026-05-17-xonsh-migration-plan.md`: Step-by-step implementation plan for the Xonsh transition.


## Key Commands

### System Management

- **Apply Configuration:**
  ```bash
  sudo nixos-rebuild switch --flake .#nixos
  ```
- **Test Configuration (without applying):**
  ```bash
  sudo nixos-rebuild test --flake .#nixos
  ```
- **Dry Run:**
  ```bash
  nixos-rebuild dry-activate --flake .#nixos
  ```
- **Check Flake Validity:**
  ```bash
  nix flake check
  ```
- **Update Lock File:**
  ```bash
  nix flake update
  ```

### Secrets Management (sops-nix)

- **Edit Secrets:**
  ```bash
  sops secrets/secrets.yaml
  ```

## Package Management Rules

When adding new packages, follow these rules to maintain consistency:

1.  **System-wide Essentials:** Add to `modules/core/default.nix` under `environment.systemPackages` only for critical CLI tools (e.g., `git`, `vim`, `wget`, `rsync`).
2.  **User-specific Applications (Home Manager):** **This is the preferred location.** Add to `users/sagar/home.nix` under `home.packages` for simple GUI apps and user tools.
3.  **Programs with Dedicated Options:** If a program has a specific Home Manager or NixOS module (e.g., `programs.firefox.enable = true`), use that in `users/sagar/home.nix` or a dedicated file in `users/sagar/programs/`.
4.  **Fonts:** Add to `modules/core/default.nix` under `fonts.packages`.
5.  **Desktop-specific Tools:** Add to the relevant module in `modules/desktop/` (e.g., `hyprland.nix`) only if the package is a system-level dependency for that environment.
6.  **Browser & Heavy System Apps:** Add to `users/sagar/default.nix` under `users.users.sagar.packages` if the package needs specific system-level integrations (e.g., `firefox`).
7.  **Complex Configurations:** If a package requires custom settings, interactive configuration, or more than a few lines of setup, **do not** add it to `home.nix` directly. Instead:
    - Create a dedicated file: `users/sagar/programs/<name>.nix`.
    - Import the new file in `users/sagar/home.nix`.
    - This keeps the main configuration files clean and modular.

## Development Conventions

- **Modularity:** Always prefer adding new functionality as a dedicated file in `users/sagar/programs/` (for user apps) or `modules/` (for system services).
- **Git Awareness:** Nix Flakes are Git-aware. If the project is initialized as a Git repository, any new files MUST be added to the Git index (`git add <file>`) before Nix can see them.
- **Experimental Features:** The project relies on `nix-command` and `flakes`, which are enabled in `modules/core/default.nix`.
- **Formatting:** Use `nixfmt-rfc-style` for formatting Nix files.

## TODO / Future Improvements

- [x] Fully integrate Home Manager for user-specific dotfile management.
- [x] Implement a secrets management solution (`sops-nix`).
- [x] Initialize Git repository to track configuration changes.
- [ ] Set up automated backup for critical data.
- [ ] Configure a persistent storage solution if moving to an impermanence setup.
