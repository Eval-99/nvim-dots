-- Create horizontal terminal and cd to cwd.
vim.api.nvim_create_user_command('TermHori', function()
  vim.cmd('split | resize 10 | lcd %:p:h | terminal')
  vim.b.from_term_command = true
end, {})

-- Create vertical terminal and cd to cwd.
vim.api.nvim_create_user_command('TermVert', function()
  vim.cmd('vsplit | lcd %:p:h | terminal')
  vim.b.from_term_command = true
end, {})

-- Keymaps to open terminals
vim.keymap.set('n', '<Leader>th', ':TermHori<CR>', { desc = 'Open horizontal terminal', silent = true })
vim.keymap.set('n', '<Leader>tv', ':TermVert<CR>', { desc = 'Open vertical terminal', silent = true })

-- Use Esc Esc to enter the terminal normal mode.
vim.keymap.set('t', '<ESC><ESC>', '<C-\\><C-n>', { desc = 'Enter terminal normal mode' })

-- Start terminal in insert mode.
vim.api.nvim_create_autocmd({ 'TermOpen', 'WinEnter' }, {
  group = vim.api.nvim_create_augroup('terminal_insert', { clear = true }),
  callback = function()
    vim.defer_fn(function()
      if vim.bo.buftype == 'terminal' and vim.b.from_term_command then
        vim.cmd('startinsert')
      end
    end, 10)
  end,
})

-- Set number and relativenumber when entering terminal normal mode.
vim.api.nvim_create_autocmd({ 'TermLeave' }, {
  group = vim.api.nvim_create_augroup('terminal_set_number', { clear = true }),
  callback = function()
    vim.cmd('setlocal number relativenumber')
  end,
})

-- Unset number and relativenumber when entering terminal insert mode.
vim.api.nvim_create_autocmd({ 'TermEnter' }, {
  group = vim.api.nvim_create_augroup('terminal_unset_number', { clear = true }),
  callback = function()
    vim.cmd('setlocal nonumber norelativenumber')
  end,
})
