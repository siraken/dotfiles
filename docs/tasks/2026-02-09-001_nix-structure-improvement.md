# Nix Directory Structure Improvement Plan

## Current Issues

### 1. No module exports from flake (Critical)

The current `flake.nix` only exports `darwinConfigurations` / `homeConfigurations`. There is no output like `inputs.dotfiles.homeManagerModules.default` for other flakes to consume, making reuse impossible.

```nix
# Current: nothing exported
# Needed:
homeManagerModules.default = ...;
darwinModules.default = ...;
```

### 2. `nix/modules/` are plain functions, not NixOS/HM modules

`aliases.nix`, `variable.nix`, `path.nix`, `nixpkgs.nix` are all simple functions like `{ pkgs }: ...` that don't use the NixOS module system's `options` / `config` pattern.

```nix
# Current (variable.nix)
{ }: { EDITOR = "nvim"; ... }

# Problem: cannot override or extend from external flakes
```

Without the module system, overrides like `config.dotfiles.variables.EDITOR = "vim"` are not possible.

### 3. Massive duplication across home.nix files

Comparing the 4 `home.nix` files reveals nearly identical import lists manually maintained:

| | darwin | darwin-min | wsl-ubuntu | minimal |
| --- | --- | --- | --- | --- |
| import count | ~52 | ~51 | ~51 | ~6 |
| diff | difftastic, ghostty, services | no ghostty | no difftastic, adds gcc | minimal set |

Adding or removing a program requires editing multiple files, making diff management difficult.

### 4. `user` is semi-hardcoded

`user` is defined in `let` within `flake.nix` and passed via `specialArgs`. This makes it difficult to override when used from other flakes. It should be defined as module `options`.

### 5. Program modules lack enable guards

Each `nix/programs/*/default.nix` activates immediately upon import. Without `mkEnableOption`, programs cannot be conditionally enabled/disabled as part of a profile.

## Recommended Structure

### A. Profile-based module design

```
nix/
├── modules/
│   └── home-manager/
│       ├── default.nix          # Main module (options definition)
│       ├── profiles/
│       │   ├── full.nix         # Equivalent to darwin/home.nix full set
│       │   ├── standard.nix     # Equivalent to darwin-min/wsl
│       │   └── minimal.nix      # Minimal configuration
│       ├── aliases.nix          # home.shellAliases as HM module
│       ├── variables.nix        # sessionVariables as HM module
│       ├── path.nix             # sessionPath as HM module
│       └── packages.nix         # home.packages as HM module
├── programs/                    # Keep as-is (add enable guard to each module)
└── hosts/                       # Keep as-is (thin wrappers referencing profiles)
```

### B. Main module design

```nix
# nix/modules/home-manager/default.nix
{ config, lib, ... }:
let
  cfg = config.dotfiles;
in
{
  options.dotfiles = {
    enable = lib.mkEnableOption "siraken's dotfiles";

    profile = lib.mkOption {
      type = lib.types.enum [ "full" "standard" "minimal" ];
      default = "standard";
    };

    user = {
      name = lib.mkOption { type = lib.types.str; };
      email = lib.mkOption { type = lib.types.str; };
      signingKey = lib.mkOption { type = lib.types.str; default = ""; };
    };

    # Per-program overrides
    programs = {
      git.enable = lib.mkOption { type = lib.types.bool; default = true; };
      tmux.enable = lib.mkOption { type = lib.types.bool; default = true; };
      # ...
    };
  };

  imports = [
    ./aliases.nix
    ./variables.nix
    ./packages.nix
  ];

  config = lib.mkIf cfg.enable {
    # Set program enable defaults based on profile
  };
}
```

### C. Flake exports

```nix
flake = {
  homeManagerModules = {
    default = ./nix/modules/home-manager;
    # Individual modules also available
    git = ./nix/programs/git;
    tmux = ./nix/programs/tmux;
  };

  darwinModules.default = ./nix/modules/darwin;

  # Existing configurations remain
  darwinConfigurations = { ... };
  homeConfigurations = { ... };
};
```

### D. Usage from other flakes

```nix
# Another machine's flake.nix
{
  inputs.dotfiles.url = "github:siraken/dotfiles";

  outputs = { dotfiles, home-manager, ... }: {
    homeConfigurations."another-user" = home-manager.lib.homeManagerConfiguration {
      modules = [
        dotfiles.homeManagerModules.default
        {
          dotfiles = {
            enable = true;
            profile = "standard";
            user = {
              name = "Another User";
              email = "other@example.com";
            };
            programs.ghostty.enable = false;  # Disable individually
          };
        }
      ];
    };
  };
}
```

## Priority

| Priority | Item | Reason |
| --- | --- | --- |
| **High** | Export `homeManagerModules` from flake | Cannot use from other flakes without this |
| **High** | Eliminate home.nix duplication via profiles | High maintenance cost |
| ~~**Medium**~~ | ~~Convert modules/ to proper HM modules~~ | ~~Needed for overridability~~ ✅ Done ([#60](https://github.com/siraken/dotfiles/pull/60)) |
| **Medium** | Add `mkEnableOption` to programs/ | Needed for conditional activation |
| **Low** | Convert `user` to options | Needed for external use but can be incremental |
| **Low** | Export darwinModules | HM modules come first |
