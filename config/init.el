;;; init.el --- Clean config (no dashboard) -*- lexical-binding: t; -*-

;; -------------------------------
;; Bootstrap straight.el
;; -------------------------------
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

(straight-use-package 'use-package)
(setq straight-use-package-by-default t)
(setq warning-minimum-level :error)
;; -------------------------------
;; UI
;; -------------------------------
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(setq inhibit-startup-screen t)

(set-face-attribute 'default nil :font "JetBrainsMono NF" :height 110)

;; Tokyo Night theme
(use-package doom-themes
  :config (load-theme 'doom-tokyo-night t))

;; Line numbers
(add-hook 'prog-mode-hook #'display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; -------------------------------
;; ESC = universal cancel
;; -------------------------------
(global-set-key (kbd "<escape>") #'keyboard-escape-quit)
(setq keyboard-escape-quit-quit-window t)

;; -------------------------------
;; Evil
;; -------------------------------
(use-package evil
  :init
  (setq evil-want-integration t
        evil-want-keybinding nil)
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "<escape>") #'keyboard-escape-quit)
  (define-key evil-visual-state-map (kbd "<escape>") #'keyboard-escape-quit)
  (define-key evil-insert-state-map (kbd "<escape>") #'evil-normal-state))

;; -------------------------------
;; Leader key
;; -------------------------------
(use-package general
  :after evil
  :config
  (general-create-definer my/leader
    :states '(normal visual emacs)
    :keymaps 'override
    :prefix "SPC"
    :global-prefix "C-SPC"))

;; -------------------------------
;; Which-key
;; -------------------------------
(use-package which-key
  :config
  (which-key-mode)

  ;; ⏱ Delay (fast but not distracting)
  (setq which-key-idle-delay 0.3)

  ;; 🎯 Clean separators (BIG readability win)
  (setq which-key-separator " → ")
  (setq which-key-prefix-prefix "+")

  ;; 📐 Layout tuning
  (setq which-key-max-description-length 40)
  (setq which-key-add-column-padding 2)
  (setq which-key-min-display-lines 6)

  ;; 📊 Use side window (like Doom)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-side-window-max-height 0.4)
  (setq which-key-side-window-max-width 0.33)

  ;; 🔤 Sorting (predictable order)
  (setq which-key-sort-order #'which-key-key-order-alpha)

  ;; 🧠 Better help integration
  (setq which-key-show-early-on-C-h t)
  (setq which-key-use-C-h-commands t)

  ;; 🎨 Prefix display
  (setq which-key-show-prefix 'left))

;; -------------------------------
;; Minibuffer / Completion
;; -------------------------------
(use-package vertico
  :init
  (vertico-mode)
  (setq vertico-cycle t))

(use-package orderless
  :init
  (setq completion-styles '(orderless basic)
        completion-category-defaults nil
        completion-category-overrides '((file (styles partial-completion)))))
(setq completion-at-point-functions
      (list #'lsp-completion-at-point))

(use-package marginalia
  :init (marginalia-mode))

(use-package consult)

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-cycle t)
  (corfu-preview-current t)
  (corfu-preselect 'prompt))

(use-package cape
  :init
  (add-to-list 'completion-at-point-functions #'cape-file)
  (add-to-list 'completion-at-point-functions #'cape-keyword))
(use-package flycheck
  :init (global-flycheck-mode))
(use-package savehist
  :init (savehist-mode))

(with-eval-after-load 'vertico
  (define-key vertico-map (kbd "C-j") #'vertico-next)
  (define-key vertico-map (kbd "C-k") #'vertico-previous)
  (define-key vertico-map (kbd "<escape>") #'keyboard-escape-quit))

(setq consult-preview-key "M-.")


;; -------------------------------
;; LSP (SMART)
;; -------------------------------
(use-package lsp-mode
  :commands lsp
  :hook ((rust-mode . lsp))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-rust-analyzer-cargo-watch-command "clippy"
        lsp-rust-analyzer-server-display-inlay-hints t
        lsp-idle-delay 0.5))

(use-package lsp-ui
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil
        lsp-ui-doc-position 'at-point
        lsp-ui-doc-delay 0.2
        lsp-ui-doc-show-with-cursor nil
        lsp-ui-doc-show-with-mouse nil

        lsp-ui-sideline-enable t
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-code-actions t))
(with-eval-after-load 'lsp-ui-doc
  (define-key lsp-ui-doc-frame-mode-map (kbd "j") #'lsp-ui-doc-scroll-up)
  (define-key lsp-ui-doc-frame-mode-map (kbd "k") #'lsp-ui-doc-scroll-down))

(defun my/lsp-setup ()
  (unless (derived-mode-p 'emacs-lisp-mode)
    (lsp)))
(setq lsp-signature-auto-activate t)
(setq lsp-signature-render-documentation t)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "K")
	      #'lsp-describe-thing-at-point))
(with-eval-after-load 'help-mode
  (define-key help-mode-map (kbd "q") #'quit-window))

(use-package cargo
  :hook (rust-mode . cargo-minor-mode))

(add-hook 'rust-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))

(add-hook 'prog-mode-hook #'my/lsp-setup)
(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-modeline-code-actions-enable t)
(setq lsp-modeline-diagnostics-enable t)
(setq lsp-warn-no-matched-clients nil)

;; -------------------------------
;; Projectile
;; -------------------------------
(use-package projectile
  :config (projectile-mode))

;; -------------------------------
;; Icons
;; -------------------------------
(use-package nerd-icons)
;; Run once: M-x nerd-icons-install-fonts

;; -------------------------------
;; Dired
;; -------------------------------
(require 'dired)
(require 'dired-x)

(use-package dired
  :straight nil
  :config
  (setq dired-listing-switches "-alh --group-directories-first"
        dired-kill-when-opening-new-dired-buffer t
        delete-by-moving-to-trash t)

  (add-hook 'dired-mode-hook #'auto-revert-mode)
  (add-hook 'dired-mode-hook #'dired-hide-details-mode)

  (define-key dired-mode-map (kbd "RET") #'dired-find-file)
  (define-key dired-mode-map (kbd "^") #'dired-up-directory)

  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "h") 'dired-up-directory
      (kbd "l") 'dired-find-file)))

(use-package nerd-icons-dired
  :hook (dired-mode . nerd-icons-dired-mode))

(use-package dired-subtree
  :after dired
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "TAB") 'dired-subtree-toggle)))

(use-package peep-dired
  :after dired
  :config
  (with-eval-after-load 'evil
    (evil-define-key 'normal dired-mode-map
      (kbd "P") 'peep-dired)))

;; -------------------------------
;; Open config shortcut
;; -------------------------------
(defun my/open-config ()
  (interactive)
  (find-file user-init-file))

;; -------------------------------
;; Keybindings
;; -------------------------------
(my/leader
  ;; Files
  "f"  '(:ignore t :which-key "files")
  "ff" '(find-file :which-key "find file")
  "fs" '(save-buffer :which-key "save file")
  "fc" '(my/open-config :which-key "open config")

  ;; Buffers
  "b"  '(:ignore t :which-key "buffers")
  "bb" '(consult-buffer :which-key "switch buffer")
  "bd" '(kill-buffer :which-key "kill buffer")

  ;; Search
  "s"  '(:ignore t :which-key "search")
  "sf" '(consult-find :which-key "find files")
  "sr" '(consult-ripgrep :which-key "ripgrep")

  ;; Projects
  "p"  '(:ignore t :which-key "projects")
  "pf" '(projectile-find-file :which-key "find file")

  ;; Dired
  "d"  '(:ignore t :which-key "dired")
  "dd" '(dired :which-key "open dired")

  ;; Code
  "c"  '(:ignore t :which-key "code")
  "cd" '(lsp-find-definition :which-key "definition")
  "cr" '(lsp-rename :which-key "rename")

  ;; Toggles
  "t"  '(:ignore t :which-key "toggles")
  "tt" '(consult-theme :which-key "choose theme")

  ;; Quit
  "q"  '(:ignore t :which-key "quit")
  "qq" '(save-buffers-kill-terminal :which-key "quit")
  "qc" '(keyboard-escape-quit :which-key "cancel")

  ;; Window Navigation
  "w"  '(:ignore t :which-key "windows")
  "wh" '(windmove-left  :which-key "left")
  "wl" '(windmove-right :which-key "right")
  "wk" '(windmove-up    :which-key "up")
  "wj" '(windmove-down  :which-key "down")

  )

;; -------------------------------
;; Reload config
;; -------------------------------
(defun my/reload-config ()
  (interactive)
  (load-file user-init-file)
  (message "Config reloaded!"))

(my/leader
  "qr" '(my/reload-config :which-key "reload config"))

;; -------------------------------
;; Performance
;; -------------------------------
(setq gc-cons-threshold (* 50 1000 1000))
;; use-package with package.el:

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook))
(setq dashboard-center-content t)
;; vertically center content
(setq dashboard-vertically-center-content t)
;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-items '((recents   . 5)
                        (projects  . 5)
                        ))
(use-package rust-mode
  :mode "\\.rs\\'"
  :hook (rust-mode . lsp))
(general-create-definer my/local-leader
  :states '(normal visual emacs)
  :keymaps 'override
  :prefix "SPC m")
(my/local-leader
  :keymaps 'rust-mode-map

  "b" '(cargo-process-build :which-key "build")
  "r" '(cargo-process-run   :which-key "run")
  "t" '(cargo-process-test  :which-key "test")
  "c" '(cargo-process-check :which-key "check")

  "f" '(lsp-format-buffer :which-key "format")
  "a" '(lsp-execute-code-action :which-key "code action"))
(with-eval-after-load 'evil
  ;; Go to definition
  (define-key evil-normal-state-map (kbd "gd") #'lsp-find-definition)

  ;; Go to declaration
  (define-key evil-normal-state-map (kbd "gD") #'lsp-find-declaration)

  ;; Find references
  (define-key evil-normal-state-map (kbd "gr") #'lsp-find-references)

  ;; Go to implementation
  (define-key evil-normal-state-map (kbd "gi") #'lsp-find-implementation)

  ;; Type definition
  (define-key evil-normal-state-map (kbd "gt") #'lsp-find-type-definition))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "gd") #'lsp-ui-peek-find-definitions)
  (define-key evil-normal-state-map (kbd "gr") #'lsp-ui-peek-find-references))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "C-o") #'xref-pop-marker-stack))
(setq lsp-prefer-capf t)
(setq lsp-auto-guess-root t)
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "<leader>rn") #'lsp-rename)
  (define-key evil-normal-state-map (kbd "<leader>ca") #'lsp-execute-code-action))
(with-eval-after-load 'evil
  (define-key evil-normal-state-map (kbd "[d") #'flycheck-previous-error)
  (define-key evil-normal-state-map (kbd "]d") #'flycheck-next-error))
(with-eval-after-load 'evil
  ;; Make xref buffers use normal mode
  (add-hook 'xref--xref-buffer-mode-hook #'evil-normal-state))
(with-eval-after-load 'xref
  (with-eval-after-load 'evil
    ;; Ensure evil normal mode in xref buffer
    (add-hook 'xref-mode-hook
              (lambda ()
                (evil-local-mode 1)
                (evil-normal-state)))

    ;; Override keys properly
    (evil-define-key 'normal xref-mode-map
      (kbd "j") #'xref-next-match
      (kbd "k") #'xref-prev-match
      (kbd "<return>") #'xref-goto-xref
      (kbd "q") #'quit-window)))
;; =========================================================
;; 🧹 ADVANCED FORMAT SYSTEM (LazyVim-style)
;; =========================================================

;; -------------------------------
;; Toggle (buffer-local)
;; -------------------------------

(defvar-local my/format-on-save t
  "Enable/disable format on save for this buffer.")

(defun my/toggle-format-on-save ()
  (interactive)
  (setq my/format-on-save (not my/format-on-save))
  (message "Format on save: %s" my/format-on-save))

;; -------------------------------
;; Formatter registry
;; -------------------------------

(defvar my/formatters
  '((emacs-lisp-mode . my/format-elisp)
    (rust-mode       . my/format-lsp))
  "Alist mapping major modes to formatter functions.")

;; -------------------------------
;; Formatter implementations
;; -------------------------------

(defun my/format-elisp (&optional beg end)
  "Format Emacs Lisp buffer or region."
  (if (and beg end)
      (indent-region beg end)
    (indent-region (point-min) (point-max))))

(defun my/format-lsp (&optional beg end)
  "Format using LSP (region if available)."
  (when (and (bound-and-true-p lsp-mode)
	     (lsp-feature? "textDocument/formatting"))
    (if (and beg end (lsp-feature? "textDocument/rangeFormatting"))
	(lsp-format-region beg end)
      (lsp-format-buffer))))

;; -------------------------------
;; Core format function (async-safe)
;; -------------------------------

(defun my/format-buffer (&optional beg end)
  "Format buffer or region intelligently."
  (interactive)
  (let ((formatter (cdr (assoc major-mode my/formatters))))
    (cond
     ;; 1. Use mode-specific formatter
     (formatter
      (funcall formatter beg end))

     ```
     ;; 2. Try LSP fallback
     ((and (bound-and-true-p lsp-mode)
	   (lsp-feature? "textDocument/formatting"))
      (my/format-lsp beg end))

     ;; 3. Nothing available
     (t
      (message "No formatter for %s" major-mode)))))
```

;; -------------------------------
;; Format on save (respects toggle)
;; -------------------------------

(defun my/format-before-save ()
  (when my/format-on-save
    (my/format-buffer)))

(defun my/setup-format-on-save ()
  (add-hook 'before-save-hook #'my/format-before-save nil t))

(add-hook 'prog-mode-hook #'my/setup-format-on-save)

;; =========================================================
;; 🔑 KEYBINDINGS
;; =========================================================

(my/leader
  "cf" '(my/format-buffer :which-key "format buffer")
  "cF" '(my/toggle-format-on-save :which-key "toggle format on save"))

;; =========================================================
;; 🧠 EVIL VISUAL FORMAT (= like Vim)
;; =========================================================

(defun my/format-region (beg end)
  (interactive "r")
  (my/format-buffer beg end))

(with-eval-after-load 'evil
  (define-key evil-visual-state-map (kbd "=") #'my/format-region))

(use-package lsp-java
  :after lsp
  :config
  (add-hook 'java-mode-hook #'lsp)

  ;; Performance tuning (VERY IMPORTANT)
  (setq lsp-java-server-install-dir "~/.emacs.d/jdtls/"
        lsp-java-vmargs
        '("-noverify"
          "-Xmx2G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"
          "-XX:+UseCompressedOops")))
(setq lsp-java-save-action-organize-imports t)
(my/local-leader
  :keymaps 'java-mode-map

  "m" '(:ignore t :which-key "Java")

  "o" '(lsp-java-organize-imports :which-key "organize imports")
  "r" '(lsp-rename :which-key "rename")
  "a" '(lsp-execute-code-action :which-key "code action")

  "b" '(lsp-java-build-project :which-key "build project")
  "t" '(lsp-java-run-tests :which-key "run tests"))


(add-hook 'java-mode-hook
          (lambda ()
            (add-hook 'before-save-hook #'lsp-format-buffer nil t)))
(my/leader
  "ss" '(consult-line :which-key "search in file")
  "sp" '(consult-ripgrep :which-key "search project"))

(my/leader
  "cs" '(lsp-workspace-symbol :which-key "workspace symbol"))

(setq lsp-headerline-breadcrumb-enable t)
(setq lsp-modeline-code-actions-enable t)
(setq lsp-modeline-diagnostics-enable t)

(setq gc-cons-threshold (* 100 1000 1000))
(setq read-process-output-max (* 1024 1024))
(use-package doom-modeline
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 28)
  (doom-modeline-bar-width 4)
  (doom-modeline-minor-modes nil)
  (doom-modeline-enable-word-count nil)
  (doom-modeline-buffer-file-name-style 'truncate-upto-project)
  (doom-modeline-icon t))

(use-package magit
  :commands magit-status
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))


(use-package magit
  :commands magit-status
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-fullframe-status-v1))
(my/leader
  "g"  '(:ignore t :which-key "git")
  "gs" '(magit-status :which-key "status"))
(use-package evil-collection
  :after (evil magit)
  :config
  (evil-collection-init))
(with-eval-after-load 'magit
  (add-hook 'magit-mode-hook #'evil-normal-state))
(use-package vterm
  :commands vterm
  :config
  (setq vterm-shell "/etc/profiles/per-user/sagar/bin/fish")) ;; use fish
(my/leader
  "'" '(vterm :which-key "terminal"))
(with-eval-after-load 'evil
  (define-key vterm-mode-map (kbd "<escape>") #'vterm-send-escape)

  ;; Switch to normal mode
  (evil-define-key 'insert vterm-mode-map (kbd "C-c") #'evil-normal-state)

  ;; Go back to insert mode
  (evil-define-key 'normal vterm-mode-map (kbd "i") #'evil-insert-state))
(defun my/open-terminal ()
  (interactive)
  (let ((buffer (get-buffer-create "*vterm*")))
    (display-buffer
     buffer
     '((display-buffer-in-side-window)
       (side . bottom)
       (window-height . 0.3)))
    (select-window (get-buffer-window buffer)) ;; 👈 focus it
    (unless (get-buffer-process buffer)
      (vterm buffer))
    (evil-insert-state))) ;; 👈 start typing immediately
(defun my/toggle-terminal ()
  (interactive)
  (if-let ((buf (get-buffer "*vterm*")))
      (if-let ((win (get-buffer-window buf)))
          (delete-window win)
        (progn
          (display-buffer buf)
          (select-window (get-buffer-window buf))
          (evil-insert-state)))
    (my/open-terminal)))
(my/leader
  "'" '(my/toggle-terminal :which-key "terminal"))
(add-hook 'vterm-mode-hook #'evil-insert-state)
