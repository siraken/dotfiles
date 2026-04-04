{ pkgs, lib, ... }:
let
  # プレフィックス付きツールをマッピングするヘルパー関数
  prefixTools =
    prefix: tools: lib.mapAttrs' (name: value: lib.nameValuePair "${prefix}:${name}" value) tools;
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
      };

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
