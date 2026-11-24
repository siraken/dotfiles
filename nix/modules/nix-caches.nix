# Binary cache configuration
# Determinate Nix Installer の設定が nix-darwin に上書きされるため明示的に指定
let
  caches = import ./nix-cache-list.nix;
in
{
  nix.settings = {
    inherit (caches) substituters trusted-public-keys;
    always-allow-substitutes = true;
    # Fail fast when a third-party cache is unreachable instead of waiting on
    # curl's default connect timeout. `fallback` stays false so a transient
    # outage fails loudly instead of compiling large packages (e.g. codex from
    # Rust source on cache.numtide.com) locally.
    connect-timeout = 5;
  };
}
