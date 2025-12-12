return {
  'folke/lazydev.nvim',
  ft = 'lua',
  opts = {
    library = {
      { path = 'snacks.nvim', words = { 'Snacks' } },
      { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
    },
  },
}
