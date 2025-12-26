# .NET/C# development
{ pkgs, ... }:
let
  omnisharp-extended-lsp = pkgs.vimUtils.buildVimPlugin {
    pname = "omnisharp-extended-lsp-nvim";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "Hoffs";
      repo = "omnisharp-extended-lsp.nvim";
      rev = "5b667daab948090931de0b31e4d58c6a6b0dce2f";
      hash = "sha256-YBJkW4ycKSWdB3lqZJKOCaieUt7xWyYw5kqN8RZxn90=";
    };
  };
in
{
  programs.nixvim = {
    extraPlugins = [ omnisharp-extended-lsp ];
  };
}
