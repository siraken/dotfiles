{ pkgs, repoPath, ... }:
{
  programs.fish = {
    enable = true;

    # home-manager generates one derivation per package in `home.packages` to
    # convert its man pages into fish completions (114 of them here). They can
    # never be substituted from a binary cache, so every package bump rebuilds
    # them locally. fish ships its own completions for the common tools, so the
    # trade is worth it. Flip back to `true` if a completion turns out missing.
    generateCompletions = false;

    # Source the repo fragments directly (`repoPath` follows
    # `dotfiles.linkMode`, so with the checkout a new shell picks up edits
    # without a rebuild). Sourced explicitly rather than via conf.d/ autoload
    # to keep the order/timing. See #70.
    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # Custom functions
      source ${repoPath "config/fish/function.fish"}

      # Completions
      source ${repoPath "config/fish/completion.fish"}
    '';
  };
}
