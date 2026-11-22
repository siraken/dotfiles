---
name: verify-dotfiles
description: Use when verifying that a change to this nix-darwin / NixOS / home-manager dotfiles repository actually reaches the running machine - evaluates the flake, compares the evaluated generation with the live profile, and checks the file or link a change is about without building or switching.
---

# Verifying a dotfiles change

There is no app to launch here. "The app" is the generation home-manager (and
nix-darwin / NixOS) produce from this checkout, and what `~/`, `launchd` /
`systemd --user` and the tools reading `~/.config` see at runtime. Verifying a
change means proving three links, in order:

1. the flake still evaluates for the host,
1. the evaluated generation carries the change (the `home.file` entry, the
   unit, the option value),
1. the consumer at runtime shows it (`~/.config/...` after the symlink
   resolves, the shell function, the agent).

Never stop at "the file I edited contains the text I typed". The point is that
the *generation* carries the change.

## Rules

- **Evaluate, do not build.** Every command below except `build` uses
  `nix eval` only: store paths are computed, never realised. While a change is
  being worked on (often across several PRs), builds wait until everything is
  merged. Run `hmcheck build` only when the user asks for it.
- **Never switch.** `darwin-rebuild switch`, `nixos-rebuild switch` and
  `home-manager switch` are the user's to run. If a check cannot be observed
  without activating, report it as NOT VERIFIED with the reason instead of
  weakening the check until it passes.
- **Run nix serially.** A second evaluation blocks on the store lock rather
  than failing, and one evaluation of this flake takes 30 s or more.
- **Do not commit what the checks print.** The repository is public; output
  contains store paths, home paths and host details.

## Helper

`scripts/hmcheck`, read-only except for `build` / `cleanup`, whose out-links
live under `~/.local/state/dotfiles/hmcheck/` (never in the repo):

| Command | What it answers |
| --- | --- |
| `hmcheck doctor` | Does the host's configuration evaluate, and how does it compare with the live profile? |
| `hmcheck fresh` | Is the evaluated home generation the live one? Exit 1 when stale |
| `hmcheck fresh-system` | The same for `/run/current-system` (nix-darwin / NixOS) |
| `hmcheck diff` | `home.file` targets added (`+`), removed (`-`) or changed (`~`) relative to the live profile |
| `hmcheck resolve REL` | Which `home.file` entry covers `~/REL`, its source, and what `~/REL` resolves to now |
| `hmcheck units` | `launchd.agents` (macOS) / `systemd.user` units the configuration declares |
| `hmcheck build` | Build the activation package; only on request |
| `hmcheck cleanup` | Remove the out-links `build` created |

The host attributes default to `$USER@$(hostname -s)` and `$(hostname -s)`.
Override with `HMCHECK_HOME=siraken@<host>` / `HMCHECK_HOST=<host>`, for
example to evaluate a host you are not on (only the evaluation is meaningful
then; the live comparison is against this machine).

## Procedure

1. `hmcheck doctor`. A failed evaluation is the only reason to stop and report
   a blocker instead of a result.
1. Read the freshness line:
   - `FRESH` - the live generation is this checkout, so anything under `~/`
     is evidence about it.
   - `STALE` - `~/` still shows the configuration of the last switch. Use
     `hmcheck diff` to see which targets differ and verify through the
     evaluated values, not through `~/`. Say in the report that the machine is
     stale.
   - `STALE (activation only)` - `home-files` match, but packages, session
     variables or agents differ. `diff` will be empty; check `units` and the
     option values with `nix eval` instead.
1. Pick the cheapest check that observes the change, and name it in the
   report:
   - **Option value**:
     `nix eval --json '.#homeConfigurations."siraken@<host>".config.<option>'`
     (for the system: `.#darwinConfigurations.<host>.config.<option>`).
   - **Generated file**: `hmcheck resolve REL`, then `hmcheck diff` to see that
     only the targets you meant to touch changed. A `~` entry you did not
     expect is a finding, not noise - unless it comes from a `flake.lock`
     change since the last switch.
   - **Repo-linked file** (`mkRepoLink`): with `dotfiles.linkMode = "outOfStore"`
     `~/REL` is a symlink into `~/dotfiles`, so an edit there is live without a
     switch: check it with `readlink -f ~/REL` and by running the consumer
     (`zsh -ic 'which x'`, `bash -ic 'type x'`, `git config --get x`).
     With `"store"` the file is a copy in the Nix store and changes only on
     the next switch.

## Gotchas

- **Worktrees are not live.** `outOfStore` links point at `~/dotfiles`, not
  at the worktree you are editing. An edit in a worktree never shows up under
  `~/`; verify it through the evaluated values (step 3) and say so.
- **Repo-linked files do not change the generation.** The source of a
  `mkRepoLink` entry is a symlink to a fixed path, so editing the linked file
  leaves `hmcheck diff` empty. That is expected, not proof that nothing
  changed.
- **`diff` covers `home.file` only** (including `xdg.configFile`). Activation
  scripts - the `~/.claude/settings.json` merge, the git persona files - write
  outside it and have to be checked by reading the file they produce.
- **A dirty tree is normal.** `warning: Git tree ... is dirty` is filtered out;
  untracked files are not part of the flake, so a new file must be
  `git add`-ed (not committed) before evaluation can see it.
- `readlink` on a profile link returns a relative name; always compare
  `readlink -f` results.
