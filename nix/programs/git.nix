{ pkgs, lib, ... }:
{
  programs.git = {
    enable = true;

    userName = "Kento Shirasawa";
    userEmail = "shirasawa.kento@gmail.com";

    extraConfig = {
      core = {
        autocrlf = "input";
        ignorecase = false;
        editor = "nvim";
        hooksPath = "~/.config/git/hooks";
      };

      user = {
        username = "siraken";
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjyytl+QL/ikAdL+f/xIl4/QeT/Pic9I+r/+nW7lAIL";
      };

      github = {
        user = "siraken";
      };

      init = {
        defaultBranch = "main";
      };

      filter.lfs = {
        smudge = "git-lfs smudge -- %f";
        process = "git-lfs filter-process";
        required = true;
        clean = "git-lfs clean -- %f";
      };

      diff = {
        tool = "difftastic";
      };

      pager = {
        difftool = true;
      };

      safe = {
        directory = "*";
      };

      # OS-specific credential and GPG configuration
      credential = lib.mkMerge [
        {
          "https://github.com" = {
            helper = lib.mkIf pkgs.stdenv.isDarwin "!/opt/homebrew/bin/gh auth git-credential";
          };
          "https://gist.github.com" = {
            helper = lib.mkIf pkgs.stdenv.isDarwin "!/opt/homebrew/bin/gh auth git-credential";
          };
        }
        (lib.mkIf pkgs.stdenv.isLinux {
          "https://github.com".helper = "!gh auth git-credential";
          "https://gist.github.com".helper = "!gh auth git-credential";
        })
        # Windows support can be added when needed
        # Windows:
        # [credential "https://github.com"]
        #   helper = !'C:\\Program Files\\GitHub CLI\\gh.exe' auth git-credential
        # [credential "https://gist.github.com"]
        #   helper = !'C:\\Program Files\\GitHub CLI\\gh.exe' auth git-credential
        # [gpg]
        #   format = ssh
        #   # program = !'C:\\Program Files\\Git\\usr\\bin\\gpg.exe'
        # [gpg "ssh"]
        #   program = "C:/Users/siraken/AppData/Local/1Password/app/8/op-ssh-sign.exe"
        # WSL:
        # [gpg]
        #   format = ssh
        # [gpg "ssh"]
        #   program = "/mnt/c/Users/siraken/AppData/Local/1Password/app/8/op-ssh-sign-wsl"
      ];

      gpg = {
        format = "ssh";
      } // (lib.optionalAttrs pkgs.stdenv.isDarwin {
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      }) // (lib.optionalAttrs pkgs.stdenv.isLinux {
        ssh.program = "/mnt/c/Users/siraken/AppData/Local/1Password/app/8/op-ssh-sign-wsl";
      });

      color = {
        status = "auto";
        diff = "auto";
        branch = "auto";
        interactive = "auto";
        grep = "auto";
        ui = "auto";
      };

      commit = {
        verbose = true;
        gpgsign = true;
      };

      push = {
        default = "simple";
        autoSetupRemote = true;
      };

      pull = {
        rebase = true;
      };

      fetch = {
        prune = true;
      };

      rebase = {
        autostash = true;
      };

      difftool = {
        prompt = false;
        sourcetree.cmd = "opendiff \"$LOCAL\" \"$REMOTE\"";
        difftastic.cmd = "difft \"$LOCAL\" \"$REMOTE\"";
        nvimdiff.cmd = "nvim -d \"$LOCAL\" \"$REMOTE\"";
      };

      mergetool = {
        nvimdiff = {
          cmd = "nvim -d \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"";
          trustExitCode = true;
        };
        sourcetree = {
          cmd = "/Applications/Sourcetree.app/Contents/Resources/opendiff-w.sh \"$LOCAL\" \"$REMOTE\" -ancestor \"$BASE\" -merge \"$MERGED\"";
          trustExitCode = true;
        };
      };

      ghq = {
        root = "~/repos";
      };
    };

    aliases = {
      d = "diff";
      b = "branch";
      br = "branch";
      ad = "add";
      us = "reset HEAD";
      bm = "branch -m";
      bD = "branch -D";
      cm = "commit";
      ecm = "commit --allow-empty";
      co = "checkout";
      st = "status";
      wt = "worktree";
      ps-f = "push --force-with-lease";
      ps = "push";
      pl = "pull";
      rb = "rebase";
      mg = "merge --no-ff";
      mgff = "merge --ff";
      fe = "fetch";
      l = "log";
      lg = "log --graph";
      lol = "log --oneline";
      bg = "log --graph --simplify-by-decoration --pretty=format:'%d' --all";
      cp = "cherry-pick";
      dt = "difftool";
      undo = "reset --soft HEAD^";
      stp = "stash pop";
      sts = "stash save";
      stl = "stash list";
      sta = "stash apply";
      rhh = "reset --hard HEAD";
      gh = "!gh repo view --web";
      cz = "!cz";
      update-from = "!f(){ echo \"Update from $1...\" && git checkout $1 && git pull && git checkout - && git merge -; };f";
    };

    ignores = [
      ".DS_Store"
      "Thumbs.db"
      "desktop.ini"
      ".idea"
      ".vscode"
      "**/.claude/settings.local.json"
    ];
  };
}
