{ config, lib, ... }:
{
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };

  # bash-preexec (used by atuin) absorbs PROMPT_COMMAND entries into its own
  # internal arrays, hiding __zoxide_hook from zoxide's doctor check and
  # producing a false-positive warning. The hook still runs correctly.
  # Keep this local to bash (not exported) so zsh retains zoxide's doctor check,
  # even when launched from a bash shell.
  programs.bash.initExtra =
    lib.mkIf (config.programs.bash.enable && config.programs.zoxide.enableBashIntegration)
      ''
        _ZO_DOCTOR=0
      '';
}
