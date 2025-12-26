# Clojure development
{ pkgs, ... }:
let
  vim-jack-in = pkgs.vimUtils.buildVimPlugin {
    pname = "vim-jack-in";
    version = "2024-12-26";
    src = pkgs.fetchFromGitHub {
      owner = "clojure-vim";
      repo = "vim-jack-in";
      rev = "45e5293cff0802a51dbed31a9b0141b0f80e2952";
      hash = "sha256-4kYY0jUv5U2i+G/29vPOZHqUX/cEQTWBo9pghRg9gIw=";
    };
  };
in
{
  programs.nixvim = {
    globals."conjure#mapping#doc_word" = "K";

    plugins.conjure.enable = true;

    extraPlugins = with pkgs.vimPlugins; [
      nvim-paredit
      vim-jack-in
    ];

    extraConfigLua = ''
      require("nvim-paredit").setup({
        filetypes = { "clojure", "lisp", "scheme", "fennel" },
      })
    '';
  };
}
