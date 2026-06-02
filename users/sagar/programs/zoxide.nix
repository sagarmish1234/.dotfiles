{ ... }:

{
  # Zoxide: A smarter 'cd' command that learns your habits.
  programs.zoxide = {
    enable = true;
    options = [
      "--cmd cd" # Replace the standard 'cd' command with 'z'.
    ];
    enableFishIntegration = true;
    enableBashIntegration = true;
  };
}
