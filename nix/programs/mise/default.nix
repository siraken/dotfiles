{ pkgs, lib, ... }:
let
  # プレフィックス付きツールをマッピングするヘルパー関数
  prefixTools =
    prefix: tools: lib.mapAttrs' (name: value: lib.nameValuePair "${prefix}:${name}" value) tools;

  # cargo パッケージ
  cargo = {
    # cargo-binstall = "latest";
    # cargo-generate = "latest";
    # diesel_cli = "latest";
    # dioxus-cli = "latest";
    # du-dust = "latest";
    # evcxr_repl = "latest";
    # gitoxide = "latest";
    # pagefind = "latest";
    # spotify_player = "latest";
  };

  # gem パッケージ
  gem = {
    rails = "latest";
    rubocop = "latest";
    rufo = "latest";
    solargraph = "latest";
    slim = "latest";
    htmlbeautifier = "latest";
    # neovim = "latest";
  };
in
{
  programs.mise = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
    globalConfig = {
      tools = {
        usage = "latest";
        dotnet = "latest";
        ruby = "latest";
        zig = "latest";
      }
      // prefixTools "cargo" cargo
      // prefixTools "gem" gem;

      settings = {
        idiomatic_version_file_enable_tools = [ ];
        status = {
          missing_tools = "if_other_versions_installed";
          show_env = false;
          show_tools = false;
        };
      };
    };
  };
}
