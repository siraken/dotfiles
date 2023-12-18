return {
  -- https://github.com/norcalli/nvim-colorizer.lua
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  -- https://github.com/roobert/tailwindcss-colorizer-cmp.nvim
  { 'roobert/tailwindcss-colorizer-cmp.nvim' },
}
