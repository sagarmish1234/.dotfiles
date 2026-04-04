{ config, pkgs, ... }:
{
  services.gnome.gnome-online-accounts.enable = true;
  services.gvfs.enable = true;
  environment.systemPackages = with pkgs; [
    gnome-control-center
    # Optional: a keyring is often needed to save the login session
    gnome-keyring
  ];

  # Ensure the keyring service starts
  services.gnome.gnome-keyring.enable = true;

}
