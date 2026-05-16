{ lib, config, ... }:
{
  programs.starship = {
    enable = true;
    settings = {
      format = ''
        [$directory$git_branch$git_status]($style)$character
      '';

      character = {
        success_symbol = lib.mkDefault "[❯](bold #${config.lib.stylix.colors.base0C})";
        error_symbol = lib.mkDefault "[✗](bold #${config.lib.stylix.colors.base08})";
      };

      directory = {
        truncation_length = 3;
        truncation_symbol = "…/";
        repo_root_style = "bold #${config.lib.stylix.colors.base0E}";
        repo_root_format = "[$repo_root]($repo_root_style)[$path]($style)[$read_only]($read_only_style) ";
      };

      git_branch = {
        format = "[$branch]($style) ";
        style = "italic #${config.lib.stylix.colors.base0E}";
      };

      git_status = {
        style = lib.mkDefault "bold #${config.lib.stylix.colors.base09}";
        ahead = "⇡\${count}";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}";
      };
    };
  };
}
