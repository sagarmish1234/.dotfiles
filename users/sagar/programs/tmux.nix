{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    
    # Ergonomic prefix: Ctrl-a (remaps from Ctrl-b)
    prefix = "C-a";
    
    # Start numbering windows and panes at 1 for natural keyboard finger reach
    baseIndex = 1;
    
    # Use Vim keys in copy mode
    keyMode = "vi";
    
    # Enable mouse support for resizing panes, selecting tabs, and scrolling
    mouse = true;
    
    # Eliminate escape key delay (crucial for responsive Vim/Neovim editing)
    escapeTime = 0;
    
    # High history limit for scrollback buffer
    historyLimit = 10000;
    
    # Set proper terminal profile
    terminal = "tmux-256color";

    # Plugins:
    # - sensible: standard sane default settings
    # - vim-tmux-navigator: seamless navigation between Vim and Tmux panes
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
    ];

    # Ergonomic keybindings and tweaks
    extraConfig = ''
      # Split panes using | and - (opening them in the current directory)
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      unbind '"'
      unbind %

      # Switch windows using Alt-Shift-H and Alt-Shift-L without prefix
      bind -n M-H previous-window
      bind -n M-L next-window

      # Automatically renumber windows when one is closed
      set -g renumber-windows on

      # Vi-mode copy adjustments: use 'v' to select and 'y' to yank/copy
      bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel

      # Easy config reloading with prefix + r
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "Tmux config reloaded!"
    '';
  };
}
