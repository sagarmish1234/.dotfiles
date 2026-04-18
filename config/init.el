
;;; init.el --- Personal Emacs Configuration -*- lexical-binding: t; -*-
;;
;; Author: Sagar
;; Description: A clean, Evil-based Emacs config with LSP, Org, Vterm,
;;              Git integration, and language support for Rust, Java, and Nix.
;;
;; ┌─────────────────────────────────────────────────────────────────────────┐
;; │  TABLE OF CONTENTS                                                      │
;; │                                                                         │
;; │  1.  Bootstrap (straight.el + use-package)                              │
;; │  2.  UI & Appearance                                                    │
;; │  3.  Theme (Catppuccin)                                                 │
;; │  4.  Evil Mode (Vim keybindings)                                        │
;; │  5.  Leader Key (general.el)                                            │
;; │  6.  Which-key (keybinding hints)                                       │
;; │  7.  Minibuffer & Completion (Vertico, Orderless, Corfu, Cape)          │
;; │  8.  LSP (Language Server Protocol)                                     │
;; │  9.  Formatter System                                                   │
;; │  10. Projectile (project management)                                    │
;; │  11. Dired (file manager)                                               │
;; │  12. Vterm (terminal emulator)                                          │
;; │  13. Git (Magit + git-gutter)                                           │
;; │  14. Language: Rust                                                     │
;; │  15. Language: Java                                                     │
;; │  16. Language: Nix                                                      │
;; │  17. Org Mode (notes, tasks, agenda)                                    │
;; │  18. Modeline (doom-modeline)                                           │
;; │  19. Miscellaneous (icons, comments, keybindings)                       │
;; │  20. Performance                                                        │
;; └─────────────────────────────────────────────────────────────────────────┘

;;; =========================================================================
;;; 1. BOOTSTRAP — straight.el + use-package
;;; =========================================================================
;; straight.el is a functional, reproducible package manager that replaces
;; the built-in package.el. It installs packages directly from source (git).

(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        user-emacs-directory))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Integrate straight.el with use-package so all :ensure t → straight.el
(straight-use-package 'use-package)
(setq straight-use-package-by-default t)

;; Suppress warnings below :error to keep *Warnings* buffer quiet
(setq warning-minimum-level :error)


;;; =========================================================================
;;; 2. UI & APPEARANCE
;;; =========================================================================

;; Minimal chrome — remove bars we don't need
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Disable the default startup screen in favour of dashboard (see §19)
(setq inhibit-startup-screen t)

;; Primary font — requires JetBrainsMono Nerd Font to be installed
(set-face-attribute 'default nil :font "JetBrainsMono NF" :height 110)

;; Relative line numbers in all programming buffers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Make ESC act like a universal cancel (similar to Doom/Spacemacs behaviour)
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)
(setq keyboard-escape-quit-quit-window t)


;;; =========================================================================
;;; 3. THEME — Catppuccin
;;; =========================================================================
;; Catppuccin is a pastel, warm-toned theme family.
;; Available flavors: latte | frappe | macchiato | mocha

(use-package catppuccin-theme
  :config
  (setq catppuccin-flavor 'mocha)
  (load-theme 'catppuccin t))


;;; =========================================================================
;;; 4. EVIL MODE — Vim keybindings inside Emacs
;;; =========================================================================
;; evil-want-keybinding nil is required before loading evil so that
;; evil-collection can set its own bindings without conflicts.

(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode 1)
  ;; ESC in normal/visual should cancel; in insert should return to normal
  (define-key evil-normal-state-map (kbd "<escape>") #'keyboard-escape-quit)
  (define-key evil-visual-state-map (kbd "<escape>") #'keyboard-escape-quit)
  (define-key evil-insert-state-map (kbd "<escape>") #'evil-normal-state))

;; evil-collection sets sensible Evil bindings for many built-in modes
;; (dired, magit, xref, help, etc.)
(use-package evil-collection
  :after (evil magit)
  :config
  (evil-collection-init))

;; evil-nerd-commenter — toggle comments with gcc / gc<motion>
(use-package evil-nerd-commenter
  :after evil
  :config
  (evilnc-default-hotkeys))


;;; =========================================================================
;;; 5. LEADER KEY — general.el
;;; =========================================================================
;; general.el provides a clean API for defining leader-key prefixed bindings.
;; SPC is the leader in normal/visual; C-SPC works everywhere.

(use-package general
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC")

  ;; A second definer for major-mode local bindings (SPC m ...)
  (general-create-definer my/local-leader
    :states '(normal visual emacs)
    :prefix "SPC m"))

;; ── Files ────────────────────────────────────────────────────────────────
(my/leader
  "f"  '(:ignore t :which-key "files")
  "ff" '(find-file          :which-key "find file")
  "fs" '(save-buffer        :which-key "save file")
  "fc" '(my/open-config     :which-key "open config")
  "fj" '(dired-jump         :which-key "jump to dired window")
  "fd" '(my/deploy-commit-push-init-el :which-key "deploy config"))

;; ── Buffers ──────────────────────────────────────────────────────────────
(my/leader
  "b"  '(:ignore t :which-key "buffers")
  "bb" '(consult-buffer      :which-key "switch buffer")
  "bd" '(kill-current-buffer :which-key "kill buffer"))

;; ── Search ───────────────────────────────────────────────────────────────
(my/leader
  "s"  '(:ignore t :which-key "search")
  "ss" '(consult-line        :which-key "search in file")
  "sf" '(consult-find        :which-key "find files")
  "sr" '(consult-ripgrep     :which-key "ripgrep")
  "sp" '(consult-ripgrep     :which-key "search project")
  "/"  '(consult-ripgrep     :which-key "search project"))

;; ── Projects ─────────────────────────────────────────────────────────────
(my/leader
  "p"  '(:ignore t :which-key "projects")
  "pf" '(projectile-find-file :which-key "find file"))

;; ── Dired ────────────────────────────────────────────────────────────────
(my/leader
  "d"  '(:ignore t :which-key "dired")
  "dd" '(dired :which-key "open dired"))

;; ── Code / LSP ───────────────────────────────────────────────────────────
(my/leader
  "c"  '(:ignore t :which-key "code")
  "cd" '(lsp-find-definition    :which-key "definition")
  "cr" '(lsp-rename             :which-key "rename")
  "cf" '(my/format-buffer       :which-key "format buffer")
  "cF" '(my/toggle-format-on-save :which-key "toggle format on save")
  "cs" '(lsp-workspace-symbol   :which-key "workspace symbol"))

;; ── Toggles ──────────────────────────────────────────────────────────────
(my/leader
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(consult-theme :which-key "choose theme"))

;; ── Windows ──────────────────────────────────────────────────────────────
(my/leader
  "w"  '(:ignore t :which-key "windows")
  "wh" '(windmove-left  :which-key "left")
  "wl" '(windmove-right :which-key "right")
  "wk" '(windmove-up    :which-key "up")
  "wj" '(windmove-down  :which-key "down"))

;; ── Terminal ─────────────────────────────────────────────────────────────
(my/leader
  "'" '(my/toggle-terminal :which-key "terminal"))

;; ── Quit ─────────────────────────────────────────────────────────────────
(my/leader
  "q"  '(:ignore t :which-key "quit")
  "qq" '(save-buffers-kill-terminal :which-key "quit")
  "qc" '(keyboard-escape-quit       :which-key "cancel")
  "qr" '(my/reload-config           :which-key "reload config"))

;; ── Org ──────────────────────────────────────────────────────────────────
(my/leader
  "o"  '(:ignore t :which-key "org")
  "oa" '(org-agenda   :which-key "agenda")
  "oc" '(org-capture  :which-key "capture")
  "ot" '(org-todo     :which-key "todo toggle")
  "os" '(org-schedule :which-key "schedule")
  "od" '(org-deadline :which-key "deadline")
  "oi" '(my/org-insert-image-from-url :which-key "insert image from url"))

;; ── Git ──────────────────────────────────────────────────────────────────
(my/leader
  "g"  '(:ignore t :which-key "git")
  "gs" '(magit-status           :which-key "status")
  "gn" '(git-gutter:next-hunk   :which-key "next hunk")
  "gp" '(git-gutter:previous-hunk :which-key "prev hunk")
  "gr" '(git-gutter:revert-hunk :which-key "revert hunk")
  "gh" '(git-gutter:popup-hunk  :which-key "preview hunk"))


;;; =========================================================================
;;; 6. WHICH-KEY — interactive keybinding hints
;;; =========================================================================
;; Displays a popup at the bottom of the screen after a brief delay,
;; listing completions for the key sequence you've started.

(use-package which-key
  :config
  (which-key-mode)

  ;; Delay before popup appears (seconds)
  (setq which-key-idle-delay 0.3)

  ;; Visual style
  (setq which-key-separator    " → "
        which-key-prefix-prefix "+")

  ;; Layout
  (setq which-key-max-description-length  40
        which-key-add-column-padding       2
        which-key-min-display-lines        6)

  ;; Show as a bottom side-window (Doom-style)
  (setq which-key-side-window-location   'bottom
        which-key-side-window-max-height  0.4
        which-key-side-window-max-width   0.33)

  ;; Alphabetical sorting for predictable order
  (setq which-key-sort-order #'which-key-key-order-alpha)

  ;; C-h integration
  (setq which-key-show-early-on-C-h t
        which-key-use-C-h-commands   t)

  ;; Show the active prefix on the left
  (setq which-key-show-prefix 'left))


;;; =========================================================================
;;; 7. MINIBUFFER & COMPLETION
;;; =========================================================================

;; ── Vertico — vertical minibuffer completion UI ──────────────────────────
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))  ; wrap around at top/bottom

;; C-j/C-k navigation in vertico (familiar Vim-style)
(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-j") #'vertico-next)
  (define-key vertico-map (kbd "C-k") #'vertico-previous)
  (define-key vertico-map (kbd "<escape>") #'keyboard-escape-quit))

;; ── Orderless — fuzzy/space-separated completion matching ────────────────
(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))

;; ── Marginalia — rich annotations in the minibuffer ──────────────────────
(use-package marginalia
  :init (marginalia-mode))

;; ── Consult — enhanced search & navigation commands ─────────────────────
(use-package consult)
(setq consult-preview-key "M-.")  ; Preview on M-. rather than automatically

;; ── Corfu — in-buffer popup completion (replaces company) ────────────────
(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto    t)    ; trigger completion automatically
  (corfu-cycle   t)    ; wrap around the candidate list
  (corfu-preview-current t)
  (corfu-preselect 'prompt))

;; ── Cape — additional completion-at-point backends for Corfu ─────────────
(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))

;; Prefer LSP capf as the primary completion source
(setq completion-at-point-functions (list #'lsp-completion-at-point))
(setq lsp-prefer-capf t)

;; ── Flycheck — on-the-fly syntax checking ────────────────────────────────
(use-package flycheck
  :init (global-flycheck-mode))

;; Navigate between errors with ]d / [d (Evil style)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "[d") #'flycheck-previous-error)
  (define-key evil-normal-state-map (kbd "]d") #'flycheck-next-error))

;; ── Savehist — persist minibuffer history across sessions ────────────────
(use-package savehist
  :init (savehist-mode))


;;; =========================================================================
;;; 8. LSP — Language Server Protocol
;;; =========================================================================
;; lsp-mode connects Emacs to external language servers for IDE-like features:
;; completions, diagnostics, go-to-definition, rename, code actions, etc.

(use-package lsp-mode
  :commands lsp
  :hook ((rust-mode . lsp))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-rust-analyzer-cargo-watch-command     "clippy"
        lsp-rust-analyzer-server-display-inlay-hints t
        lsp-idle-delay                              0.5))

;; LSP UI — sideline diagnostics / peek windows / doc popups
(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable         nil    ; disable auto doc popup
        lsp-ui-doc-position        'at-point
        lsp-ui-doc-delay           0.2
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse  nil

        lsp-ui-sideline-enable          t
        lsp-ui-sideline-show-hover      nil
        lsp-ui-sideline-show-code-actions t))

;; Scroll the lsp-ui doc frame with j/k when it's open
(with-eval-after-load 'lsp-ui-doc
  (define-key lsp-ui-doc-frame-mode-map (kbd "j") #'lsp-ui-doc-scroll-up)
  (define-key lsp-ui-doc-frame-mode-map (kbd "k") #'lsp-ui-doc-scroll-down))

;; LSP modeline features
(setq lsp-headerline-breadcrumb-enable t
      lsp-modeline-code-actions-enable t
      lsp-modeline-diagnostics-enable  t
      lsp-warn-no-matched-clients      nil)

;; Signature help in the echo area
(setq lsp-signature-auto-activate     t
      lsp-signature-render-documentation t)

;; Auto-detect project root
(setq lsp-auto-guess-root t)

;; Start LSP for all prog-mode buffers (except elisp, which has no server)
(defun my/lsp-setup ()
  "Start LSP unless we're in an Emacs Lisp buffer."
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp)))

(add-hook 'prog-mode-hook #'my/lsp-setup)

;; ── LSP / xref navigation keybindings (normal-state) ────────────────────
(with-eval-after-load 'evil

  ;; Peek definitions / references (lsp-ui overlays)
  (define-key evil-normal-state-map (kbd "gd") #'lsp-ui-peek-find-definitions)
  (define-key evil-normal-state-map (kbd "gr") #'lsp-ui-peek-find-references)

  ;; Standard xref / LSP navigation
  (define-key evil-normal-state-map (kbd "gD") #'lsp-find-declaration)
  (define-key evil-normal-state-map (kbd "gi") #'lsp-find-implementation)
  (define-key evil-normal-state-map (kbd "gt") #'lsp-find-type-definition)

  ;; Jump back after navigating to definition
  (define-key evil-normal-state-map (kbd "C-o") #'xref-pop-marker-stack)

  ;; Hover docs with K (like Neovim)
  (define-key evil-normal-state-map (kbd "K") #'lsp-describe-thing-at-point)

  ;; Leader shortcuts for rename and code actions
  (define-key evil-normal-state-map (kbd "<leader>rn") #'lsp-rename)
  (define-key evil-normal-state-map (kbd "<leader>ca") #'lsp-execute-code-action))

;; ── xref buffer — Evil keybindings ───────────────────────────────────────
(with-eval-after-load 'evil
  (add-hook 'xref--xref-buffer-mode-hook #'evil-normal-state))

(with-eval-after-load 'xref
  (with-eval-after-load 'evil
    (add-hook 'xref-mode-hook
              (lambda ()
                (evil-local-mode 1)
                (evil-normal-state)))
    (evil-define-key 'normal xref-mode-map
      (kbd "j")       #'xref-next-match
      (kbd "k")       #'xref-prev-match
      (kbd "<return>") #'xref-goto-xref
      (kbd "q")       #'quit-window)))

;; q closes the *help* buffer too
(with-eval-after-load 'help-mode
  (define-key help-mode-map (kbd "q") #'quit-window))


;;; =========================================================================
;;; 9. FORMATTER SYSTEM — LazyVim-style smart formatting
;;; =========================================================================
;; Provides per-mode formatters with a toggle for format-on-save.
;; Keybindings: SPC c f  →  format buffer
;;              SPC c F  →  toggle format-on-save
;;              =        →  format region (visual mode)

;; ── Per-buffer toggle ────────────────────────────────────────────────────
(defvar-local my/format-on-save t
  "When non-nil, format this buffer before saving.")

(defun my/toggle-format-on-save ()
  "Toggle `my/format-on-save` for the current buffer."
  (interactive)
  (setq my/format-on-save (not my/format-on-save))
  (message "Format on save: %s" my/format-on-save))

;; ── Formatter registry ───────────────────────────────────────────────────
;; Map major-modes to formatter functions.
;; Add new entries here to support additional languages.
(defvar my/formatters
  '((emacs-lisp-mode . my/format-elisp)
    (rust-mode       . my/format-lsp))
  "Alist mapping major-modes to their formatter functions.")

;; ── Formatter implementations ────────────────────────────────────────────
(defun my/format-elisp (&optional beg end)
  "Format Emacs Lisp: indent the whole buffer or a region."
  (if (and beg end)
      (indent-region beg end)
    (indent-region (point-min) (point-max))))

(defun my/format-lsp (&optional beg end)
  "Format via the active LSP server; supports range formatting."
  (when (and (bound-and-true-p lsp-mode)
             (lsp-feature? "textDocument/formatting"))
    (if (and beg end (lsp-feature? "textDocument/rangeFormatting"))
        (lsp-format-region beg end)
      (lsp-format-buffer))))

;; ── Core formatter dispatch ──────────────────────────────────────────────
(defun my/format-buffer (&optional beg end)
  "Format the buffer (or region BEG..END) using the best available formatter.
Priority: (1) mode-specific entry in `my/formatters'
          (2) LSP fallback if lsp-mode is active
          (3) message that no formatter is available."
  (interactive)
  (let ((formatter (cdr (assoc major-mode my/formatters))))
    (cond
     (formatter
      (funcall formatter beg end))
     ((and (bound-and-true-p lsp-mode)
           (lsp-feature? "textDocument/formatting"))
      (my/format-lsp beg end))
     (t
      (message "No formatter configured for %s" major-mode)))))

;; ── Format-on-save hook ──────────────────────────────────────────────────
(defun my/format-before-save ()
  "Run `my/format-buffer' before saving if `my/format-on-save' is non-nil."
  (when my/format-on-save
    (my/format-buffer)))

(defun my/setup-format-on-save ()
  "Install the format-before-save hook locally for the current buffer."
  (add-hook 'before-save-hook #'my/format-before-save nil t))

(add-hook 'prog-mode-hook #'my/setup-format-on-save)

;; ── Visual-mode = to format region (Vim-like) ────────────────────────────
(defun my/format-region (beg end)
  "Format the active visual region."
  (interactive "r")
  (my/format-buffer beg end))

(with-eval-after-load 'evil
  (define-key evil-visual-state-map (kbd "=") #'my/format-region))


;;; =========================================================================
;;; 10. PROJECTILE — project management
;;; =========================================================================
;; Projectile understands project roots (git, cargo, etc.) and provides
;; fast file navigation, grep, and compilation commands scoped to a project.

(use-package projectile
  :config (projectile-mode))


;;; =========================================================================
;;; 11. DIRED — built-in file manager with enhancements
;;; =========================================================================

(require 'dired)
(require 'dired-x)   ; extra commands like dired-jump

(use-package dired
  :straight nil      ; built-in; don't fetch from straight
  :config
  (setq dired-listing-switches "-alh --group-directories-first"
        dired-kill-when-opening-new-dired-buffer t
        delete-by-moving-to-trash t)

  ;; Auto-refresh when files change on disk
  (add-hook 'dired-mode-hook #'auto-revert-mode)
  ;; Hide noisy detail columns by default (toggle with "("
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)

  ;; Standard navigation
  (define-key dired-mode-map (kbd "RET") #'dired-find-file)
  (define-key dired-mode-map (kbd "^")   #'dired-up-directory)

  ;; Vim-style h/l to navigate up/into directories
  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "h") #'dired-up-directory
      (kbd "l") #'dired-find-file)))

;; File-type icons in dired
(use-package nerd-icons
  :defer t)
;; Run once after install: M-x nerd-icons-install-fonts

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

;; Expand / collapse subdirectories inline (like a tree view)
(use-package dired-subtree
  :after dired
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "TAB") #'dired-subtree-toggle)))

;; Preview files in a side window without opening them
(use-package peep-dired
  :after dired
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "P") #'peep-dired)))


;;; =========================================================================
;;; 12. VTERM — proper terminal emulator
;;; =========================================================================
;; vterm is a full terminal emulator backed by libvterm.
;; The toggle below keeps a single persistent terminal buffer.

(use-package vterm
  :commands vterm
  :config
  ;; Use fish as the shell inside vterm
  (setq vterm-shell "/etc/profiles/per-user/sagar/bin/fish"))

;; Force vterm to always open at the bottom of the frame
(add-to-list 'display-buffer-alist
             '("\\*vterm\\*"
               (display-buffer-in-side-window)
               (side . bottom)
               (window-height . 0.3)))

(defvar my/vterm-buffer-name "*vterm*"
  "Name of the persistent vterm buffer.")

(defun my/open-terminal ()
  "Open (or reuse) the persistent vterm buffer and switch to insert state."
  (interactive)
  (let ((buf (get-buffer my/vterm-buffer-name)))
    (unless (and buf (buffer-live-p buf))
      (setq buf (vterm my/vterm-buffer-name)))
    (display-buffer buf)
    (select-window (get-buffer-window buf t))
    (evil-insert-state)))

(defun my/toggle-terminal ()
  "Toggle the persistent vterm: hide it if visible, open it if not."
  (interactive)
  (let ((buf (get-buffer my/vterm-buffer-name)))
    (if (and buf (get-buffer-window buf t))
        (delete-window (get-buffer-window buf t))
      (my/open-terminal))))

;; Terminal keybinding behaviour
(with-eval-after-load 'vterm
  ;; ESC should be forwarded to the shell, not captured by Emacs
  (define-key vterm-mode-map (kbd "<escape>") #'vterm-send-escape)
  (with-eval-after-load 'evil
    (evil-define-key 'insert vterm-mode-map (kbd "C-c") #'evil-normal-state)
    (evil-define-key 'normal vterm-mode-map (kbd "i")   #'evil-insert-state)))

;; Always start the terminal in insert mode
(add-hook 'vterm-mode-hook #'evil-insert-state)


;;; =========================================================================
;;; 13. GIT — Magit + git-gutter
;;; =========================================================================

;; ── Magit — the best Git interface in existence ───────────────────────────
(use-package magit
  :commands magit-status
  :config
  ;; Open magit status in a full-frame window
  (setq magit-display-buffer-function
        #'magit-display-buffer-fullframe-status-v1))

;; Start magit buffers in normal state so Evil bindings work immediately
(with-eval-after-load 'magit
  (add-hook 'magit-mode-hook #'evil-normal-state))

;; ── git-gutter — per-line diff indicators in the fringe ──────────────────
(use-package git-gutter
  :config
  (global-git-gutter-mode +1)
  (setq git-gutter:update-interval 0.2  ; refresh quickly on save
        git-gutter:modified-sign   "~"
        git-gutter:added-sign      "+"
        git-gutter:deleted-sign    "-")
  (set-face-foreground 'git-gutter:modified "orange")
  (set-face-foreground 'git-gutter:added    "green")
  (set-face-foreground 'git-gutter:deleted  "red"))

;; git-gutter-fringe — render indicators in the bitmap fringe (prettier)
(use-package git-gutter-fringe
  :after git-gutter
  :config
  (require 'git-gutter-fringe)
  (define-fringe-bitmap 'git-gutter-fr:added    [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:modified [224] nil nil '(center repeated))
  (define-fringe-bitmap 'git-gutter-fr:deleted  [128 192 224 240] nil nil 'bottom))


;;; =========================================================================
;;; 14. LANGUAGE: RUST
;;; =========================================================================

(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp))   ; also hooked in lsp-mode :hook above

;; cargo.el — run cargo commands from within Emacs
(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

;; Format Rust buffers with rust-analyzer on save
(add-hook 'rust-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))

;; Local leader bindings for Rust (SPC m ...)
(my/local-leader
  :keymaps 'rust-mode-map
  "b" '(cargo-process-build   :which-key "build")
  "r" '(cargo-process-run     :which-key "run")
  "t" '(cargo-process-test    :which-key "test")
  "c" '(cargo-process-check   :which-key "check")
  "f" '(lsp-format-buffer     :which-key "format")
  "a" '(lsp-execute-code-action :which-key "code action"))


;;; =========================================================================
;;; 15. LANGUAGE: JAVA
;;; =========================================================================
;; lsp-java wraps Eclipse JDT Language Server (jdtls).
;; The server is auto-installed to ~/.emacs.d/jdtls/ on first use.

(use-package lsp-java
  :after lsp
  :config
  (add-hook 'java-mode-hook #'lsp)

  ;; JVM tuning for jdtls — bump heap and use G1GC for responsiveness
  (setq lsp-java-server-install-dir "~/.emacs.d/jdtls/"
        lsp-java-vmargs
        '("-noverify"
          "-Xmx2G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"
          "-XX:+UseCompressedOops")))

;; Auto-organise imports on save
(setq lsp-java-save-action-organize-imports t)

;; Format Java buffers with jdtls on save
(add-hook 'java-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))

;; Local leader bindings for Java (SPC m ...)
(my/local-leader
  :keymaps 'java-mode-map
  "m" '(:ignore t            :which-key "Java")
  "o" '(lsp-java-organize-imports :which-key "organize imports")
  "r" '(lsp-rename           :which-key "rename")
  "a" '(lsp-execute-code-action :which-key "code action")
  "b" '(lsp-java-build-project :which-key "build project")
  "t" '(lsp-java-run-tests   :which-key "run tests"))


;;; =========================================================================
;;; 16. LANGUAGE: NIX
;;; =========================================================================
;; nix-mode provides syntax highlighting and indentation for .nix files.
;; The nil LSP server (https://github.com/oxalica/nil) is used for diagnostics.

(use-package nix-mode
  :mode "\\.nix\\'"
  :hook (nix-mode . lsp)
  :init
  (add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode)))

;; Register nil as the Nix language server
(with-eval-after-load 'lsp-mode
  (add-to-list 'lsp-language-id-configuration '(nix-mode . "nix"))
  (setq lsp-nix-nil-server-command '("nil")))

;; Format .nix files with nixfmt on save (requires nixfmt on PATH)
(add-hook 'nix-mode-hook
          (lambda ()
            (add-hook 'before-save-hook
                      (lambda ()
                        (when (eq major-mode 'nix-mode)
                          (shell-command-on-region
                           (point-min) (point-max)
                           "nixfmt" t t)))
                      nil t)))

;; Local leader bindings for Nix (SPC m ...)
(my/local-leader
  :keymaps 'nix-mode-map
  "a" '(lsp-execute-code-action :which-key "code action")
  "f" '(lsp-format-buffer       :which-key "format"))


;;; =========================================================================
;;; 17. ORG MODE — notes, tasks, and agenda
;;; =========================================================================
;;
;; Quick-start:
;;   mkdir ~/org && touch ~/org/{tasks,agenda,notes}.org
;;
;;   SPC o c   → capture a task or note
;;   SPC o a   → open the agenda dashboard
;;   SPC o t   → cycle a heading's TODO state
;;
;; Example headings:
;;   * TODO  Build a B+ Tree
;;   * IN-PROGRESS  Learn Rust ownership

(use-package org
  :straight nil  ; use the built-in Org
  :config

  ;; ── Directories ─────────────────────────────────────────────────────────
  (setq org-directory      "~/org/"
        org-agenda-files   '("~/org/tasks.org" "~/org/agenda.org"))

  ;; ── Visual & editing ────────────────────────────────────────────────────
  (setq org-startup-indented        t    ; indent content under headings
        org-hide-emphasis-markers   t    ; hide *bold* markers
        org-pretty-entities         t    ; render \alpha as α etc.
        org-fontify-whole-heading-line t
        org-return-follows-link     t    ; RET follows links
        org-startup-with-inline-images t
        org-image-actual-width       '(400))

  ;; TAB folds/unfolds sections
  (define-key org-mode-map (kbd "TAB") #'org-cycle)

  ;; ── TODO workflow ────────────────────────────────────────────────────────
  (setq org-todo-keywords
        '((sequence
           "TODO(t)" "IN-PROGRESS(i)" "WAITING(w)"
           "|"
           "DONE(d)" "CANCELLED(c)")))

  ;; Timestamp when marking a heading DONE
  (setq org-log-done 'time))

;; ── Capture templates ────────────────────────────────────────────────────
(setq org-capture-templates
      '(("t" "Task" entry
         (file "~/org/tasks.org")
         "* TODO %?\n  %U\n")
        ("n" "Note" entry
         (file "~/org/notes.org")
         "* %?\n  %U\n")))

;; ── org-modern — cleaner heading/bullet/table visuals ────────────────────
(use-package org-modern
  :hook (org-mode . org-modern-mode))

;; ── visual-fill-column — center the buffer like a writing app ────────────
(use-package visual-fill-column
  :hook (org-mode . my/org-visual-setup))

(defun my/org-visual-setup ()
  "Center the Org buffer and constrain its width for comfortable reading."
  (visual-fill-column-mode 1)
  (setq visual-fill-column-width        100
        visual-fill-column-center-text  t))

;; ── Babel — run code blocks inside Org files ─────────────────────────────
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python     . t)
   (shell      . t)
   (emacs-lisp . t)))

;; No confirmation prompt when evaluating code blocks
(setq org-confirm-babel-evaluate nil)

;; Refresh inline images after a babel block executes
(add-hook 'org-babel-after-execute-hook #'org-display-inline-images)

;; ── Helper: insert image from URL ────────────────────────────────────────
(defun my/org-insert-image-from-url (url)
  "Download an image from URL into an ./images/ subdirectory and insert a link."
  (interactive "sImage URL: ")
  (let* ((img-dir  (concat (file-name-directory (buffer-file-name)) "images/"))
         (filename (concat img-dir (file-name-nondirectory url))))
    (unless (file-exists-p img-dir)
      (make-directory img-dir t))
    (url-copy-file url filename t)
    (insert (format "[[file:%s]]" filename))
    (org-display-inline-images)))


;;; =========================================================================
;;; 18. MODELINE — doom-modeline
;;; =========================================================================
;; doom-modeline is a minimal, icon-rich modeline inspired by Doom Emacs.
;; It shows the current file path, branch, LSP status, and more.

(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height            28)
  (doom-modeline-bar-width          4)
  (doom-modeline-minor-modes        nil) ; hide minor mode clutter
  (doom-modeline-enable-word-count  nil)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-icon               t))


;;; =========================================================================
;;; 19. MISCELLANEOUS — dashboard, config helpers, deploy
;;; =========================================================================

;; ── Dashboard — startup screen ───────────────────────────────────────────
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))

(setq dashboard-center-content           t
      dashboard-vertically-center-content t
      dashboard-items '((recents  . 5)
                        (projects . 5)))

;; ── Config helpers ───────────────────────────────────────────────────────
(defun my/open-config ()
  "Jump directly to init.el."
  (interactive)
  (find-file user-init-file))

(defun my/reload-config ()
  "Reload init.el without restarting Emacs."
  (interactive)
  (load-file user-init-file)
  (message "Config reloaded!"))

;; ── Deploy init.el to dotfiles repo ─────────────────────────────────────
;; Copies init.el → ~/.dotfiles/config/init.el, then commits and pushes.
(defun my/deploy-commit-push-init-el ()
  "Save init.el, copy it to the dotfiles repo, commit, and push.

Fixes vs. naive version:
  1. Explicitly saves init.el regardless of which buffer is active.
  2. Passes a repo-relative path to `git add` (tilde paths confuse git).
  3. Aborts the push if the commit step fails (e.g. nothing to commit)."


  (interactive)
  (require 'magit)
  (let* ((source            user-init-file)
         (target            (expand-file-name "~/.dotfiles/config/init.el"))
         (default-directory (expand-file-name "~/.dotfiles/"))
         (commit-msg        (read-string "Commit message: ")))

    ;; Save init.el specifically, not whatever buffer happens to be active
    (with-current-buffer (find-file-noselect source)
      (save-buffer))

    ;; Copy to dotfiles repo
    (copy-file source target t)

    ;; Stage with a repo-relative path so git can actually find the file
    (magit-call-git "add" "config/init.el")

    ;; Only push if the commit succeeds (exit code 0)
    (if (= 0 (magit-call-git "commit" "-m" commit-msg))
        (progn
          (magit-call-git "push")
          (message "init.el deployed, committed, and pushed! 🚀"))
      (message "Nothing to commit — deploy skipped."))))


;;; =========================================================================
;;; 20. PERFORMANCE
;;; =========================================================================
;; Increase the GC threshold during normal use to reduce GC pauses.
;; (The default 800 KB is far too low for modern packages like LSP.)

(setq gc-cons-threshold        (* 100 1000 1000)  ; 100 MB
      read-process-output-max  (* 1024 1024))       ; 1 MB — improves LSP throughput

;;; init.el ends here
