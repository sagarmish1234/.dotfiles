{ config, pkgs, inputs, ... }:

{
  # User Account: Define the primary user 'sagar'.
  users.users."sagar" = {
    isNormalUser = true; # standard interactive user (not a system/service account).
    description = "Sagar Mishra";

    # extraGroups: Permissions granted to this user.
    # 'networkmanager': Allows connecting to Wi-Fi/Ethernet.
    # 'wheel': Allows using 'sudo' for administrative tasks.
    extraGroups = [ "networkmanager" "wheel" "podman" ];

    # Default Shell: Fish is the primary interactive shell.
    shell = pkgs.fish;

    # System-level User Packages:
    # These are installed at the system level for this specific user.
    # Prefer putting most GUI/app packages in home.nix instead.
    packages = [
      inputs.antigravity-nix.packages.${pkgs.system}.google-antigravity-cli
      pkgs.firefox # Web browser with system integration requirements.
    ];
  };
}
