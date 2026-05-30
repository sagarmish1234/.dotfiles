{ config, ... }:

{
  sops = {
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # This will automatically import the SSH keys as age keys
    age.keyFile = "/home/sagar/.config/sops/age/keys.txt";
    
    # Use the system's SSH host key for decryption at boot
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    
    # Example secret (uncomment and add to your secrets.yaml later)
    # secrets."example-password" = {
    #   neededForUsers = true;
    # };
  };
}
