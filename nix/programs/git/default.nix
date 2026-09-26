{
  pkgs,
  lib,
  config,
  inputs,
  userProfile,
  isWSL ? false,
  repoPath,
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
  imports = [ inputs.git-personas.homeModules.default ];

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

      commit.gpgsign = pkgs.stdenv.hostPlatform.isDarwin || isWSL;
    }
    // lib.optionalAttrs isWSL {
      # Repositories on the Windows drives (/mnt/c, /mnt/d, ...) are owned by a
      # different uid under WSL, which git's dubious-ownership check rejects.
      # Trust only those mounts; every other path keeps the default protection.
      # (A trailing `/*` matches everything below the prefix, git >= 2.46.)
      safe.directory = "/mnt/*";
    }
    // lib.optionalAttrs (pkgs.stdenv.hostPlatform.isDarwin || isWSL) {
      # 1Password SSH signing is available on macOS and WSL, but not on a
      # regular NixOS host.
      gpg = {
        format = "ssh";
        ssh.program =
          if pkgs.stdenv.hostPlatform.isDarwin then
            "/Applications/1Password.app/Contents/MacOS/op-ssh-sign"
          else
            "/mnt/c/Program Files/1Password/app/8/op-ssh-sign-wsl";
      };
    };

    includes = [
      { path = "${repoPath "config/git/config"}"; }
      # git-personas.nix appends its generated include after this one, so
      # persona overrides win over the shared config.
    ];

    ignores = ignoreFiles;
  };

  # Per-client identity, credential confinement and `.envrc` files. secrets.toml
  # is read at *activation* time, never during evaluation, so the flake stays
  # pure and a machine without the file simply gets no client configuration.
  programs.gitPersonas = {
    enable = true;
    personasFile = "${config.dotfiles.path}/secrets.toml";
  };
}
