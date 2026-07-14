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

  secretsPath = "${config.home.homeDirectory}/dotfiles/secrets.json";
  secrets =
    if builtins.pathExists secretsPath then builtins.fromJSON (builtins.readFile secretsPath) else { };
  gitClients = secrets.gitClients or [ ];

  ignoreFiles = [
    # macOS
    ".DS_Store"
    ".AppleDouble"
    ".LSOverride"
    ".DocumentRevisions-V100"
    ".fseventsd"
    ".Spotlight-V100"
    ".TemporaryItems"
    ".Trashes"
    ".VolumeIcon.icns"
    ".com.apple.timemachine.donotpresent"

    # Windows
    "Thumbs.db"
    "desktop.ini"

    # Editors / IDEs
    ".clj-kondo/.cache/"
    ".lsp/.cache/"
    ".idea/"
    ".vscode/"

    # Node.js
    "**/node_modules"
    "npm-debug.log*"
    "yarn-debug.log*"
    "yarn-error.log*"
    "lerna-debug.log*"
    ".pnpm-debug.log*"
    "pids"
    "*.pid"
    "*.seed"
    "*.pid.lock"
    "*.tsbuildinfo"
    ".yarn/cache"
    ".yarn/unplugged"
    ".yarn/build-state.yml"
    ".yarn/install-state.gz"
    ".pnp.*"

    # Nix / Devenv
    ".direnv"
    ".devenv*"
    "devenv.local.nix"
    "devenv.local.yaml"

    # Misc
    ".ignore/"
    ".playwright-mcp/"
    "**/.claude/settings.local.json"
    "**/.claude/worktrees/"
    "AGENTS.local.md"
    "mise.local.toml"
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
      { path = "${config.home.homeDirectory}/dotfiles/config/git/config"; }
    ]
    ++ map (c: {
      condition = "gitdir:~/repos/${c.dir}/";
      path = "~/.config/git.custom/${c.configFile}";
    }) gitClients;

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
        as = "auth status";
        co = "pr checkout";
        pv = "pr view";
        sw = "auth switch";
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
