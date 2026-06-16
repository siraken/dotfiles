{ pkgs, ... }:
{
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    silent = false;
    nix-direnv.enable = true;
    config = {
      # load_dotenv = true;
      strict_env = true;
      warn_timeout = "10s";
    };
    # Move `.direnv/` cache out of project roots so TS/Vite etc. don't scan it.
    stdlib = ''
      : ''${XDG_CACHE_HOME:=$HOME/.cache}
      declare -A direnv_layout_dirs
      direnv_layout_dir() {
        local hash path
        echo "''${direnv_layout_dirs[$PWD]:=$(
          if command -v sha1sum >/dev/null 2>&1; then
            hash="$(echo -n "$PWD" | sha1sum | cut -c1-7)"
          else
            hash="$(echo -n "$PWD" | shasum | cut -c1-7)"
          fi
          path="''${PWD//[^a-zA-Z0-9]/-}"
          echo "$XDG_CACHE_HOME/direnv/layouts/''${hash}''${path}"
        )}"
      }
    '';
    mise = {
      enable = false;
    };
  };
}
