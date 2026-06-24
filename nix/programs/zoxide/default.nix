{ pkgs, ... }:
{
  # bash-preexec (used by atuin) absorbs PROMPT_COMMAND entries into its own
  # internal arrays, hiding __zoxide_hook from zoxide's doctor check and
  # producing a false-positive warning. The hook still runs correctly.
  home.sessionVariables._ZO_DOCTOR = "0";

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    options = [ "--cmd cd" ];
  };
}
