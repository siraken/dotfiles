{ pkgs, ... }:
{
  programs.mise = {
    enable = true;
    globalConfig = {
      tools = {
        usage = "latest";
        bun = "latest";
        deno = "latest";
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

        # npm packages
        "npm:typescript" = "latest";
        # "npm:nativescript" = "latest";
        # "npm:@ionic/cli" = "latest";
        # "npm:native-run" = "latest";
        # "npm:source-map-support" = "latest";
        # "npm:@aws-amplify/cli" = "latest";
        # "npm:firebase-tools" = "latest";
        # "npm:commitizen" = "latest";
        # "npm:@angular/cli" = "latest";
        # "npm:@nestjs/cli" = "latest";
        # "npm:fastify-cli" = "latest";
        "npm:yo" = "latest";
        # "npm:json-server" = "latest";
        # "npm:cordova" = "latest";
        # "npm:typeorm" = "latest";
        "npm:wrangler" = "latest";
        # "npm:terminalizer" = "latest";
        # "npm:dredd" = "latest";
        # "npm:neovim" = "latest";
        # "npm:web-push" = "latest";
        "npm:purescript" = "latest";
        "npm:spago" = "latest";
        "npm:ccmanager" = "latest";
        "npm:dev3000" = "latest";
        "npm:@biomejs/biome" = "latest";
        "npm:@google/clasp" = "latest";
        "npm:@google/gemini-cli" = "latest";
        "npm:@github/copilot" = "latest";
        "npm:@openai/codex" = "latest";
        "npm:@anthropic-ai/claude-code" = "latest";
        "npm:@lhci/cli" = "latest";
        "npm:@nestjs/cli" = "latest";
        "npm:cordova" = "latest";
        "npm:cordova-res" = "latest";
        "npm:md-to-pdf" = "latest";

        # cargo packages
        # "cargo:cargo-binstall" = "latest";
        # "cargo:cargo-generate" = "latest";
        # "cargo:diesel_cli" = "latest";
        # "cargo:dioxus-cli" = "latest";
        # "cargo:du-dust" = "latest";
        # "cargo:evcxr_repl" = "latest";
        # "cargo:gitoxide" = "latest";
        # "cargo:pagefind" = "latest";
        # "cargo:spotify_player" = "latest";

        # gem packages
        "gem:rails" = "latest";
        "gem:rubocop" = "latest";
        "gem:rufo" = "latest";
        "gem:solargraph" = "latest";
        "gem:slim" = "latest";
        "gem:htmlbeautifier" = "latest";
        # "gem:neovim" = "latest";

        # pip packages
        # "pipx:watchdog" = "latest";

        # go packages
        # "go:golang.org/x/tools/cmd/godoc" = "latest"; # godoc
        # "go:github.com/sheepla/pingu" = "latest"; # ping alternative: pingu
        # "go:github.com/fatih/gomodifytags" = "latest"; # Go tool to modify struct field tags
        # "go:github.com/antonmedv/llama" = "latest"; # Terminal file manager
        # "go:github.com/maaslalani/nap" = "latest"; # Code snippets in terminal
      };

      settings = {
        idiomatic_version_file_enable_tools = [];

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
