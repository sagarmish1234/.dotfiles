# 🧭 Workspace Rule: Guided Context Routing

AI agents starting a session in this repository MUST follow this phased context-gathering protocol to prevent token exhaustion and context window bloat:

## 1. 📂 Step-by-Step Context Protocol
1.  **Read Root Context First**: Do not scan the entire directory tree or read every markdown file in the `docs/` folder. Instead, read the root documentation index at [GEMINI.md](file:///home/sagar/.dotfiles/GEMINI.md) to understand the current configuration layout and active guidelines.
2.  **Targeted Deep Dive**: Only open individual sub-documentation files when the task directly concerns those sections:
    *   For low-level kernel, bootloader, disk/Btrfs, performance engine, sysctl tuning, or graphics (Nvidia PRIME sync): Read [OS_ARCHITECTURE.md](file:///home/sagar/.dotfiles/docs/OS_ARCHITECTURE.md).
    *   For NixOS Stable-to-Unstable migration phases: Read [2026-05-24-nixos-unstable-migration.md](file:///home/sagar/.dotfiles/docs/plans/2026-05-24-nixos-unstable-migration.md).
    *   For shell migration context (Fish to Xonsh design & plan): Read [2026-05-17-xonsh-migration-design.md](file:///home/sagar/.dotfiles/docs/plans/2026-05-17-xonsh-migration-design.md) and [2026-05-17-xonsh-migration-plan.md](file:///home/sagar/.dotfiles/docs/plans/2026-05-17-xonsh-migration-plan.md).

## 2. ❄️ Nix Flakes Git Purity Rule
*   **Git Awareness**: This repository is a Git repository. Nix Flakes evaluate in "strict mode," meaning **any new files created must be added to the Git index (`git add <file>`)** before rebuilding. If Nix throws a "file not found" error for a newly created config, it is because it hasn't been added to Git.

## 3. 📦 Declarative Package Rules
When installing new packages, follow this order of preference:
1.  **System-wide CLI Essentials**: Put in `modules/core/default.nix` under `environment.systemPackages` (e.g. `git`, `vim`, `wget`).
2.  **User-specific Applications**: Put in `users/sagar/home.nix` under `home.packages`.
3.  **Complex/Modular App Configuration**: Create a file `users/sagar/programs/<name>.nix`, configure the options (e.g. `programs.<name>.enable = true;`), and import it inside `users/sagar/home.nix`.
