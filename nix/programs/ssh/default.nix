{
  lib,
  pkgs,
  ...
}:
{
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;

    # Keep private host entries outside this public repository. `includes` is
    # emitted before `Host *`, so per-host overrides in `~/.ssh/config.local`
    # win under OpenSSH's first-match-wins rules; missing files are ignored.
    includes = [ "config.local" ];

    settings."*" = {
      # Reuse a single connection across repeated SSH/git invocations to skip
      # redundant handshakes and 1Password agent round-trips. `%C` hashes
      # %l%h%p%r into 40 hex characters, staying under macOS's 104-byte Unix
      # socket path limit.
      ControlMaster = "auto";
      ControlPath = "~/.ssh/cm-%C";
      ControlPersist = "10m";

      # Tear down stale sessions across sleep/NAT timeouts instead of hanging
      # indefinitely (60s * 3 = 3m).
      ServerAliveInterval = 60;
      ServerAliveCountMax = 3;
    }
    // lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
      # Matches `SSH_AUTH_SOCK` in `nix/modules/variable.nix` so non-shell SSH
      # callers also use the 1Password SSH agent.
      IdentityAgent = "~/.1password/agent.sock";
    };
  };
}
