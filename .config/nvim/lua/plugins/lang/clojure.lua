-- Clojure development
return {
  -- Conjure - interactive evaluation
  {
    "Olical/conjure",
    ft = { "clojure", "fennel", "lisp", "scheme" },
    init = function()
      vim.g["conjure#mapping#doc_word"] = "K"
    end,
  },
  -- REPL jack-in
  { "clojure-vim/vim-jack-in", ft = "clojure" },
}
