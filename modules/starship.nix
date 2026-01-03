{lib, ...}:{
 programs.starship = {
    enable = true;
    settings = {
      format = ''
        [$directory$git_branch$git_status]($style)$character
      '';

      character = {
        success_symbol = lib.mkDefault "[❯](bold cyan)";
        error_symbol = lib.mkDefault "[✗](bold cyan)";
      };

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        repo_root_style = "bold cyan";
        repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "italic cyan";
      };

      git_status = {
        style = lib.mkDefault "bold red";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };

      cmd_duration = {
        min_time = 500;
        format = " took [$duration](bold yellow)";
      };
    };
  };
}