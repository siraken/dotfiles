{ pkgs, isWSL, ... }:
{
  programs._1password-shell-plugins = {
    # On WSL `op` is aliased to the Windows `op.exe` (see `wsl` in
    # modules/aliases.nix), which talks to the 1Password desktop app. The
    # plugin wrappers would then run `op.exe plugin run -- <tool>` and look for
    # the tool on the Windows side, so the plugins (and the Linux `op` they
    # install) are left out there.
    enable = !isWSL;
    plugins = with pkgs; [
      cachix
    ];
  };
}
