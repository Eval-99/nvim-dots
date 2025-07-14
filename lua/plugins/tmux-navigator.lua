return {
  'christoomey/vim-tmux-navigator',

  init = function()
    vim.g.tmux_navigator_no_mappings = true
    vim.g.tmux_navigator_no_wrap = true
  end,

  config = function()
    vim.keymap.set({ 'n', 't' }, '<C-h>', '<CMD>TmuxNavigateLeft<CR>', { silent = true })
    vim.keymap.set({ 'n', 't' }, '<C-j>', '<CMD>TmuxNavigateDown<CR>', { silent = true })
    vim.keymap.set({ 'n', 't' }, '<C-k>', '<CMD>TmuxNavigateUp<CR>', { silent = true })
    vim.keymap.set({ 'n', 't' }, '<C-l>', '<CMD>TmuxNavigateRight<CR>', { silent = true })
    vim.keymap.set({ 'n', 't' }, '<M-p>', '<CMD>TmuxNavigatePrevious<CR>', { silent = true })
  end,
}
