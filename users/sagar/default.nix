{ config, pkgs, ... }:

{
  users.users."sagar" = {
    isNormalUser = true;
    description = "Sagar Mishra";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      gemini-cli-bin
      firefox
    ];
  };
}
