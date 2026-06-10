{
  pkgs,
  lib,
  config,
  userProfile,
  ...
}:
let
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
    "**/.claude/worktrees/"
    "mise.local.toml"
    "**/node_modules"
    ".direnv"
    ".devenv*"
    "devenv.local.nix"
    "devenv.local.yaml"
    ".pre-commit-config.yaml"
  ]
  ++ dotenvFiles;
in
{
  programs.git = {
    enable = true;

    # Identity, signing, and OS-specific GPG stay in Nix (userProfile-derived and
    # host-varying). The static config (aliases, diff, color, ...) lives in a repo
    # file included directly by git, so it is editable in place without a rebuild.
    # See #70.
    settings = {
      user = {
        name = userProfile.name;
        email = userProfile.email;
        username = userProfile.username;
        signingkey = userProfile.signingKey;
      };

      github = {
        user = userProfile.username;
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
    };

    includes = [
      { path = "${config.home.homeDirectory}/dotfiles/nix/programs/git/config"; }
    ];

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
        email = userProfile.email;
        name = userProfile.name;
      };
    };
  };
}
