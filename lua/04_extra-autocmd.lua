-- Yank highlight auto command
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('config-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ 'VimResized' }, {
  desc = 'When Neovim is resized, change splits accordingly',
  group = vim.api.nvim_create_augroup('resize_splits', { clear = true }),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd('tabdo wincmd =')
    vim.cmd('tabnext ' .. current_tab)
  end,
})

-- Add cursorline only to Quickfix lists
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Cursorline in Quickfix lists',
  group = vim.api.nvim_create_augroup('quickfix cursorline', { clear = true }),
  pattern = 'qf',
  callback = function()
    vim.wo.cursorline = true
  end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd('BufEnter', { desc = 'No auto comment on newline', command = [[set formatoptions-=cro]] })
