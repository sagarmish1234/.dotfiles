{ config, pkgs, ... }: {
  # Declarative configuration of MCP servers for Antigravity/Gemini CLI
  home.file.".gemini/antigravity-cli/mcp_config.json".text = builtins.toJSON {
    mcpServers = {
      nixos = {
        command = "${pkgs.nix}/bin/nix";
        args = [
          "--extra-experimental-features"
          "nix-command flakes"
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
    };
  };

  home.file.".gemini/config/mcp_config.json".text = builtins.toJSON {
    mcpServers = {
      nixos = {
        command = "${pkgs.nix}/bin/nix";
        args = [
          "--extra-experimental-features"
          "nix-command flakes"
          "run"
          "github:utensils/mcp-nixos"
          "--"
        ];
      };
    };
  };
}
