{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    transmission_4 # Includes transmission-daemon, transmission-remote, transmission-cli
    rustmission    # Modern Ratatui-based TUI with borders and dashboard layout
  ];

  xdg.configFile."rustmission/config.toml".text = ''
    [general]
    accent_color = "Blue"
    beginner_mode = false
    headers_hide = false
    auto_hide = false

    [connection]
    url = "http://127.0.0.1:9091/transmission/rpc"
    torrents_refresh = 5
    stats_refresh = 5
    free_space_refresh = 10
  '';
}
