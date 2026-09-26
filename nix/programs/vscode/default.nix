{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles = {
      Default = {
        languageSnippets = {
          c = import ./snippets/c.nix;
          cobol = import ./snippets/cobol.nix;
          csharp = import ./snippets/csharp.nix;
          dockercompose = import ./snippets/dockercompose.nix;
          gitcommit = import ./snippets/gitcommit.nix;
          go = import ./snippets/go.nix;
          javascript = import ./snippets/javascript.nix;
          json = import ./snippets/json.nix;
          markdown = import ./snippets/markdown.nix;
          php = import ./snippets/php.nix;
          shellscript = import ./snippets/shellscript.nix;
          sql = import ./snippets/sql.nix;
          typescript = import ./snippets/typescript.nix;
          typescriptreact = import ./snippets/typescriptreact.nix;
        };

        globalSnippets = import ./snippets/global.nix;
      };
    };
  };
}
