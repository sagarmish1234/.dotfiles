{
  config,
  pkgs,
  lib,
  ...
}:
{
  # Development tools
  home.packages = with pkgs; [
    # C/C++
    gcc
    cmake
    #clang
    #cmake
    #gnumake
    #gdb
    #lldb
    #clang-tools
    #ccls
    #bear
    #valgrind

    # Database tools
    #   postgresql
    #   mysql80
    #   sqlite
    #   redis
    #   mongodb
    #   dbeaver-bin

    # Container tools
    docker
    docker-compose
    # podman
    # buildah
    # skopeo
    # dive
    # lazydocker

    # Kubernetes tools
    #   kubectl
    #   kubernetes-helm
    #   k9s
    #   kind
    #   minikube
    #   kustomize
    #   kubectx
    #   stern
    #   kubecolor

    # Cloud tools
    #   awscli2
    #   google-cloud-sdk
    #   azure-cli
    #   terraform
    #   terragrunt
    #   ansible
    #   vagrant
    #   packer

    # API development
    httpie
    curl
    bruno
    #postman
    #insomnia
    #grpcurl
    #evans

    # Build tools
    #   bazel
    #   meson
    #   ninja
    #   scons

    # Documentation tools
    #   mdbook
    #   hugo
    #   mkdocs
    #   sphinx

    # Performance tools
    #   hyperfine
    #   flamegraph
    #   perf-tools
    #   heaptrack

    # Network tools
    #wireshark
    #tcpdump
    #nmap
    netcat
    #socat
    #mtr

    # Misc development utilities
    jq
    yq-go
    # fx
    watchexec
    entr
    tmux
    tmuxinator
    asciinema
    tokei
    cloc
    tree-sitter
  ];

  # Docker daemon (only if containers feature is enabled)

  # # Podman as Docker alternative (disabled dockerCompat to avoid conflict)
  # virtualisation.podman = {
  #   enable = true;
  #   dockerCompat = false;
  #   defaultNetwork.settings.dns_enabled = true;
  # };

  # # Development services
  # services = {
  #   # PostgreSQL
  #   postgresql = {
  #     enable = false; # Set to true to enable
  #     package = pkgs.postgresql_15;
  #     dataDir = "/var/lib/postgresql/15";
  #     authentication = ''
  #       local all all trust
  #       host all all 127.0.0.1/32 trust
  #       host all all ::1/128 trust
  #     '';
  #   };

  #   # Redis
  #   redis.servers."" = {
  #     enable = false; # Set to true to enable
  #     port = 6379;
  #     bind = "127.0.0.1";
  #   };

  #   # MySQL/MariaDB
  #   mysql = {
  #     enable = false; # Set to true to enable
  #     package = pkgs.mariadb;
  #     settings = {
  #       mysqld = {
  #         bind-address = "127.0.0.1";
  #         port = 3306;
  #       };
  #     };
  #   };
  # };

  # Development shell environments
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  # Git configuration

  # Enable lorri for automatic nix-shell
  services.lorri.enable = true;
}
