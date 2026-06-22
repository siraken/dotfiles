{
  pkgs,
  config,
  mkRepoLink,
  ...
}:
{
  programs.fish = {
    enable = true;

    # Source the fragments from out-of-store symlinks (same order as before) so
    # they are editable in place — a new shell picks up edits without a rebuild.
    # Sourced explicitly rather than via conf.d/ autoload to preserve the
    # original order/timing. See #70.
    interactiveShellInit = ''
      # Disable greeting
      set fish_greeting

      # Custom functions
      source ${config.home.homeDirectory}/.config/fish/function.fish

      # Completions
      source ${config.home.homeDirectory}/.config/fish/completion.fish

      # Conditional aliases
      if type -q bat
        alias cat="bat"
      end

      if type -q eza
        alias ll="eza -l -g --icons --sort=type"
        alias lla="ll -a"
      end
    '';
  };

  home.file = {
    ".config/fish/function.fish".source = mkRepoLink "config/fish/function.fish";
    ".config/fish/completion.fish".source = mkRepoLink "config/fish/completion.fish";
  };
}
