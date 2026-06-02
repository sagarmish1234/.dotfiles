{ config, ... }:

{
  # Sops-nix: Declarative secrets management.
  sops = {
    # Default Secrets File: The encrypted YAML file containing your keys/passwords.
    defaultSopsFile = ../../secrets/secrets.yaml;
    defaultSopsFormat = "yaml";

    # Age Key: The private key used to decrypt the secrets.
    # We use a standard Age key file located in the user's config.
    age.keyFile = "/home/sagar/.config/sops/age/keys.txt";
    
    # SSH Host Key: This allows the system to decrypt secrets during boot 
    # using the machine's unique ED25519 host key.
    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];
    
    # Example Secret Definition:
    # secrets."example-password" = {
    #   neededForUsers = true; # Available during the user creation phase.
    # };
  };
}
