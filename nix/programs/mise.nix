{ pkgs, lib, ... }:
let
  # プレフィックス付きツールをマッピングするヘルパー関数
  prefixTools =
    prefix: tools: lib.mapAttrs' (name: value: lib.nameValuePair "${prefix}:${name}" value) tools;

  # npm パッケージ
  npm = {
    typescript = "latest";
    # nativescript = "latest";
    # "@ionic/cli" = "latest";
    # native-run = "latest";
    # source-map-support = "latest";
    # "@aws-amplify/cli" = "latest";
    # firebase-tools = "latest";
    # commitizen = "latest";
    # "@angular/cli" = "latest";
    # fastify-cli = "latest";
    yo = "latest";
    # json-server = "latest";
    # typeorm = "latest";
    wrangler = "latest";
    # terminalizer = "latest";
    # dredd = "latest";
    # neovim = "latest";
    # web-push = "latest";
    purescript = "latest";
    spago = "latest";
    ccmanager = "latest";
    dev3000 = "latest";
    "@google/clasp" = "latest";
    "@github/copilot" = "latest";
    "@lhci/cli" = "latest";
    "@nestjs/cli" = "latest";
    "@antfu/ni" = "latest";
    "@typescript/native-preview" = "latest";
    cordova = "latest";
    cordova-res = "latest";
    md-to-pdf = "latest";
  };

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

  # pipx パッケージ
  pipx = {
    # watchdog = "latest";
  };

  # go パッケージ
  go = {
    # "golang.org/x/tools/cmd/godoc" = "latest"; # godoc
    # "github.com/sheepla/pingu" = "latest"; # ping alternative: pingu
    # "github.com/fatih/gomodifytags" = "latest"; # Go tool to modify struct field tags
    # "github.com/antonmedv/llama" = "latest"; # Terminal file manager
    # "github.com/maaslalani/nap" = "latest"; # Code snippets in terminal
  };
in
{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        usage = "latest";
        node = "latest";
        dotnet = "latest";
        erlang = "latest";
        elixir = "latest";
        ruby = "latest";
        zig = "latest";
        ghq = "latest";
        uv = "latest";
        go = "latest";
        rust = "latest";
      }
      // prefixTools "npm" npm
      // prefixTools "cargo" cargo
      // prefixTools "gem" gem
      // prefixTools "pipx" pipx
      // prefixTools "go" go;

      settings = {
        idiomatic_version_file_enable_tools = [ ];

        npm = {
          bun = false;
        };

        pipx = {
          uvx = true;
        };

        status = {
          missing_tools = "if_other_versions_installed";
          show_env = false;
          show_tools = false;
        };
      };
    };
  };
}
