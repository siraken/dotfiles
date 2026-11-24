{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs.atuin = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    # atuin 18.19 以降は `?` を AI 起動ウィジェットに bind するため、
    # URL のクエリ文字列などで `?` が打てなくなる。bind だけ外す
    # (`atuin ai inline` は引き続き手動で呼べる)
    flags = [ "--disable-ai" ];

    settings = {
      dialect = "us";
      auto_sync = true;
      search_mode = "fuzzy";
      style = "full";
      invert = false;
      show_preview = true;
      exit_mode = "return-query"; # return-original or return-query
      secrets_filter = true;
      theme = {
        name = "autumn";
        debug = false;
        max_depth = 10;
      };
    };

    # Avoid direct SQLite writes from preexec/precmd (WAL lock contention across
    # concurrent panes/agents). Enabled on macOS (launchd) here and on NixOS
    # hosts in `nix/modules/home/nixos-host.nix` (systemd). Non-NixOS Linux
    # (`wsl-ubuntu`, generic profiles) keeps it off: Home Manager writes
    # `daemon.enabled = true` unconditionally on Linux, and Atuin prints errors
    # on every command when no user systemd daemon is running.
    daemon.enable = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin (lib.mkDefault true);
  };

  # Run in the `user` launchd domain rather than `gui`: atuin-daemon needs no
  # Aqua session, and `gui/$UID` is unavailable on headless SSH logins (e.g.
  # siraken-macmini).
  launchd.agents.atuin-daemon.domain = lib.mkIf (
    pkgs.stdenv.hostPlatform.isDarwin && config.programs.atuin.daemon.enable
  ) (lib.mkDefault "user");
}
