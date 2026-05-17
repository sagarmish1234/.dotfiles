# Xonsh Migration Implementation Plan

> **For Gemini:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Replace fish with xonsh as the default system-wide shell while maintaining feature parity (autosuggestions, starship).

**Architecture:** Create a new `modules/shell/xonsh.nix` module managed via Home Manager. Update `feature.nix` to toggle the shell. Perform a global search-and-replace of hardcoded fish paths in editors, terminals, and emacs.

**Tech Stack:** Nix, Home Manager, Xonsh, Xontribs (fish-completer, whole-word-completions, prompt-starship).

---

### Task 1: Toggle Shell in feature.nix

**Files:**
- Modify: `feature.nix`

**Step 1: Update feature flags**
Add `xonsh = true;` and set `fish = false;`.

```nix
  shell = {
    xonsh = true;
    fish = false;
    zsh = false;
    bash = true;
  };
```

**Step 2: Commit**

```bash
git add feature.nix
git commit -m "feat: toggle xonsh in feature flags"
```

---

### Task 2: Create Xonsh Module

**Files:**
- Create: `modules/shell/xonsh.nix`

**Step 1: Write the xonsh module**
Ensure it includes `xontrib-fish-completer`, `xontrib-whole-word-completions`, and `xontrib-prompt-starship`.

```nix
{ lib, feature, pkgs, ... }:
lib.mkIf (feature.shell.xonsh or false) {
  programs.xonsh = {
    enable = true;
    package = pkgs.xonsh;
    config = ''
      # Load xontribs
      xontrib load fish_completer whole_word_completions prompt_starship

      # Aliases
      aliases['btop'] = "btop --force-utf"
      aliases['nrs'] = "sudo nixos-rebuild switch --flake ~/.dotfiles"

      # Environment
      $TITLE = "xonsh"
      $VI_MODE = True
      $UPDATE_OS_ENVIRON = True
    '';
  };
}
```

**Step 2: Commit**

```bash
git add modules/shell/xonsh.nix
git commit -m "feat: add xonsh module with xontribs"
```

---

### Task 3: Set Login Shell in configuration.nix

**Files:**
- Modify: `configuration.nix`

**Step 1: Set shell for user sagar**
Add `shell = pkgs.xonsh;` to the user definition.

```nix
  users.users.sagar = {
    isNormalUser = true;
    # ...
    shell = pkgs.xonsh;
  };
```

**Step 2: Commit**

```bash
git add configuration.nix
git commit -m "feat: set xonsh as login shell for sagar"
```

---

### Task 4: Update Neovim Integration

**Files:**
- Modify: `modules/editors/nvim.nix`

**Step 1: Update shell path**
Replace `${pkgs.fish}/bin/fish` with `${pkgs.xonsh}/bin/xonsh`.

```nix
        shell = "${pkgs.xonsh}/bin/xonsh";
```

**Step 2: Commit**

```bash
git add modules/editors/nvim.nix
git commit -m "feat: update neovim shell to xonsh"
```

---

### Task 5: Update Ghostty Integration

**Files:**
- Modify: `modules/ghostty.nix`

**Step 1: Update shell and disable fish integration**
Update `command` and set `enableFishIntegration = false;`.

```nix
    enableFishIntegration = false;
    settings = {
      command = "${pkgs.xonsh}/bin/xonsh";
    };
```

**Step 2: Commit**

```bash
git add modules/ghostty.nix
git commit -m "feat: update ghostty shell to xonsh"
```

---

### Task 6: Update Zed Integration

**Files:**
- Modify: `modules/editors/zed-editor.nix`

**Step 1: Update shell path**
Update `terminal.program` to `xonsh`.

```nix
          program = "xonsh";
```

**Step 2: Commit**

```bash
git add modules/editors/zed-editor.nix
git commit -m "feat: update zed shell to xonsh"
```

---

### Task 7: Update Emacs vterm shell

**Files:**
- Modify: `config/init.el`

**Step 1: Update vterm-shell path**
Update the path to use the xonsh profile location.

```elisp
  (setq vterm-shell "/etc/profiles/per-user/sagar/bin/xonsh"))
```

**Step 2: Commit**

```bash
git add config/init.el
git commit -m "feat: update emacs vterm shell to xonsh"
```

---

### Task 8: Update Tmux Integration

**Files:**
- Modify: `modules/shell/apps/tmux.nix`

**Step 1: Update shell path**
Update `programs.tmux.shell`.

```nix
    shell = "${pkgs.xonsh}/bin/xonsh";
```

**Step 2: Commit**

```bash
git add modules/shell/apps/tmux.nix
git commit -m "feat: update tmux shell to xonsh"
```

---

### Task 9: Final Verification (Dry Build)

**Step 1: Run dry build**
Run: `nix build .#nixosConfigurations.nixos.config.system.build.toplevel --dry-run`
Expected: Success

**Step 2: Test xonsh binary manually**
Run: `nix shell nixpkgs#xonsh -c xonsh` (just to verify the shell itself runs if needed, though the build check is more important for config correctness).

**Step 3: Final Commit**

```bash
git commit --allow-empty -m "feat: xonsh migration complete"
```
