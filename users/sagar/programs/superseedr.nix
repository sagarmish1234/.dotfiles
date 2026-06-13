{ config, pkgs, ... }:

{
  xdg.configFile."jagalite.superseedr/settings.toml" = {
    text = ''
      bootstrap_nodes = [
          "router.utorrent.com:6881",
          "router.bittorrent.com:6881",
          "dht.transmissionbt.com:6881",
          "dht.libtorrent.org:25401",
          "router.cococorp.de:6881",
      ]
      client_id = "-SS1000-hqEgnc9JR9He"
      client_leeching_fallback_interval_secs = 60
      client_port = 6681
      connection_attempt_permits = 50
      default_download_folder = "/home/sagar/Downloads"
      global_download_limit_bps = 0
      global_upload_limit_bps = 0
      lifetime_downloaded = 0
      lifetime_uploaded = 0
      max_concurrent_validations = 64
      max_connected_peers = 2000
      output_status_interval = 0
      peer_sort_column = "UL"
      peer_sort_direction = "Descending"
      peer_sort_pinned = false
      peer_upload_in_flight_limit = 4
      private_client = false
      schema_version = 1
      torrent_sort_column = "Up"
      torrent_sort_direction = "Descending"
      torrent_sort_pinned = false
      torrents = []
      tracker_fallback_interval_secs = 1800
      ui_theme = "tokyo_night"
      upload_slots = 8

      [rss]
      enabled = true
      feeds = []
      filters = []
      max_preview_items = 500
      poll_interval_secs = 900
    '';
    force = true;
  };
}
