# .NET/C# development
{ pkgs, ... }:
let
  omnisharp-extended-lsp = pkgs.vimUtils.buildVimPlugin {
    pname = "omnisharp-extended-lsp-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "Hoffs";
      repo = "omnisharp-extended-lsp.nvim";
      rev = "a47388e5417e7f1cfa6962cc441a23c4c5fb2151";
      hash = "sha256-0cRngH9BFuBbEu7007Xqr5zVJSBUowni7jxaMxGwnzU=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ omnisharp-extended-lsp ];
  };
}
