{ ... }:
{
  programs.git = {
    enable = true;
    userName = "Sagar Mishra";
    userEmail = "sagarmish1234@gmail.com"; # Fallback
    # sops-nix will override this if configured
    settings = {
      # user = {
      #   name = "Sagar Mishra";
      #   email = "sagarmish1234@gmail.com";
      # };
      alias = {
        a = "add";
        b = "branch";
        c = "commit";
        ca = "commit --amend";
        cm = "commit -m";
        co = "checkout";
        d = "diff";
        ds = "diff --staged";
        l = "log --oneline";
        ll = "log";
        p = "push";
        pf = "push --force-with-lease";
        pl = "pull";
        r = "rebase";
        s = "status --short";
        ss = "status";
        sw = "switch";
        forgor = "commit --amend --no-edit";
        graph = "log --all --decorate --graph --oneline";
        oops = "checkout --";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autoStash = true;
    };
  };
}
