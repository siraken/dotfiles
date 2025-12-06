-- Common Lisp development
return {
  -- Vlime - Common Lisp IDE
  {
    "vlime/vlime",
    ft = "lisp",
    init = function()
      vim.g.vlime_cl_impl = "sbcl"
    end,
  },
}
