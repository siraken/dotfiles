{ pkgs, lib, ... }:
let
  name = "Kento Shirasawa";
  email = "shirasawa@novalumo.com";
  username = "siraken";

  dotenvEnvironments = [
    "local"
    "development"
    "staging"
    "production"
  ];

  dotenvFiles = lib.concatMap (env: [
    ".env.${env}"
    ".dev.vars.${env}"
  ]) dotenvEnvironments;

  ignoreFiles = [
    ".DS_Store"
    "Thumbs.db"
    "desktop.ini"
    ".clj-kondo/.cache/"
    ".lsp/.cache/"
    ".idea/"
    ".vscode/"
    ".ignore/"
    ".playwright-mcp/"
    "**/.claude/settings.local.json"
    "mise.local.toml"
    ".direnv/"
    "**/node_modules"
  ]
  ++ dotenvFiles;
in
{
  programs.git = {
    enable = true;
    settings = {
      core = {
        autocrlf = "input";
        editor = "nvim";
        hooksPath = "~/.config/git/hooks";
      };

      user = {
        name = name;
        email = email;
        username = username;
        signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOjyytl+QL/ikAdL+f/xIl4/QeT/Pic9I+r/+nW7lAIL";
      };

      alias = {
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
        sp = "stash pop";
        ss = "stash save";
        sl = "stash list";
        sa = "stash apply";
        rhh = "reset --hard HEAD";
        gh = "!gh repo view --web";
        cz = "!cz";
        update-from = "!f(){ echo \"Update from $1...\" && git checkout $1 && git pull && git checkout - && git merge -; };f";
      };

      github = {
        user = username;
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

      column = {
        ui = "auto";
      };

      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };

      pager = {
        difftool = true;
      };

      safe = {
        directory = "*";
      };

      # OS-specific GPG configuration for 1Password SSH signing
      gpg = {
        format = "ssh";
      }
      // (lib.optionalAttrs pkgs.stdenv.isDarwin {
        ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
      })
      // (lib.optionalAttrs pkgs.stdenv.isLinux {
        ssh.program = "/mnt/c/Program Files/1Password/app/8/op-ssh-sign-wsl";
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
        pruneTags = true;
        all = true;
      };

      rebase = {
        autostash = true;
      };

      difftool = {
        prompt = false;
        sourcetree.cmd = "opendiff \"$LOCAL\" \"$REMOTE\"";
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
        root = [
          "~/repos"
          "~/go/src"
        ];
      };
    };

    ignores = ignoreFiles;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
      hosts = [
        "https://github.com"
        "https://gist.github.com"
      ];
    };
    extensions = with pkgs; [
      gh-markdown-preview
    ];
    settings = {
      aliases = {
        co = "pr checkout";
        pv = "pr view";
      };
      git_protocol = "https";
    };
  };

  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        email = email;
        name = name;
      };
    };
  };
}
