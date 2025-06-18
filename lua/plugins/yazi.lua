---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  event = 'VeryLazy',
  dependencies = {
    'folke/snacks.nvim',
  },
  keys = {
    {
      '<leader>lf',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'Open yazi at the current file',
    },
    {
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "Open the file manager in nvim's working directory",
    },
  },
  ---@type YaziConfig | {}
  opts = {
    yazi_floating_window_border = 'rounded',
    floating_window_scaling_factor = 0.8,
    keymaps = {
      show_help = '<f1>',
    },
  },
}
