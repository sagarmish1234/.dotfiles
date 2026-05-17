# Design Doc: Migrating from Fish to Xonsh

**Date:** 2026-05-17
**Status:** Validated
**Topic:** Complete system-wide migration from `fish` shell to `xonsh` with "fish-like" feature parity.

## Overview
The goal is to replace `fish` with `xonsh` as the default interactive shell across the entire NixOS/Home Manager environment. The new setup will prioritize Python-powered flexibility while maintaining the high-quality UX features of fish, specifically autosuggestions and Starship integration.

## Architecture

### 1. Home Manager Module (`modules/shell/xonsh.nix`)
A new declarative module will be created using `programs.xonsh`.
- **Package**: `pkgs.xonsh`
- **Xontribs (Plugins)**:
    - `xontrib-fish-completer`: Core completion logic.
    - `xontrib-whole-word-completions`: Fish-style ghost text autosuggestions.
    - `xontrib-prompt-starship`: Integration for existing Starship prompt.
- **Configuration**: Managed via `programs.xonsh.config` to inject aliases and initialization logic (greeting, environment variables).

### 2. Feature Toggling (`feature.nix`)
- Replace `feature.shell.fish` with `feature.shell.xonsh`.
- Update all conditional logic in the codebase to depend on the new xonsh toggle.

## System Integration

### 1. Hardcoded Reference Updates
The following files will be updated to point to `${pkgs.xonsh}/bin/xonsh`:
- **Neovim**: `modules/editors/nvim.nix`
- **Zed**: `modules/editors/zed-editor.nix`
- **Ghostty**: `modules/ghostty.nix` (also disabling `enableFishIntegration`).
- **Emacs**: `config/init.el` (updating `vterm-shell`).
- **Tmux**: `modules/shell/apps/tmux.nix`

### 2. Login Shell
The user's login shell will be explicitly set to xonsh in the system configuration:
`users.users.sagar.shell = pkgs.xonsh;`

## Testing & Validation

### 1. Pre-Switch Validation
- Build the configuration without switching.
- Manually execute the xonsh binary from the current shell.
- Verify:
    - Starship prompt renders correctly.
    - Aliases (`nrs`, `btop`) are functional.
    - Autosuggestions (gray text) appear as expected.

### 2. Integration Verification
- Confirm editors (Neovim/Zed) spawn xonsh correctly.
- Confirm terminal (Ghostty) starts directly into xonsh.

### 3. Rollback/Safety
- Keep `fish` installed temporarily as a fallback binary to ensure system access in case of configuration errors.
