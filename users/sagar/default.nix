{ config, pkgs, inputs, ... }:

let
  browserPolicies = {
    policies = {
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/latest.xpi";
          installation_mode = "force_installed";
        };
        "{7493aaa9-f9ba-4705-9e60-f421f1d1844b}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/clearurls/latest.xpi";
          installation_mode = "force_installed";
        };
        "browsec@browsec.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/browsec/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
in
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

  # System-wide browser policies (workaround for home-manager wrapping bug with unwrapped binaries)
  environment.etc."firefox/policies/policies.json".text = builtins.toJSON browserPolicies;
  environment.etc."zen/policies/policies.json".text = builtins.toJSON browserPolicies;
}
