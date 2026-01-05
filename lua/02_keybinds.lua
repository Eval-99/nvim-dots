-- Exit insert mode
vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode with jj' })

-- Move vim splits
vim.keymap.set('n', '<M-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<M-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<M-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<M-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

-- Resize vim splits
vim.keymap.set('n', '<C-up>', '<cmd>resize +3<CR>', { desc = 'Resize up' })
vim.keymap.set('n', '<C-down>', '<cmd>resize -3<CR>', { desc = 'Resize down' })
vim.keymap.set('n', '<C-left>', '<cmd>vertical resize +3<CR>', { desc = 'Resize left' })
vim.keymap.set('n', '<C-right>', '<cmd>vertical resize -3<CR>', { desc = 'Resize right' })

-- use 'U' to redo instead of <C-R>
vim.keymap.set('n', 'U', '<C-R>', { desc = 'Use "U" to redo' })

-- <leader>r to replace string under cursor. This is still useful since even if the LSP can rename variables, it cannot search and replace plain string as far as I know.
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = 'Replace word under cursor for the entire file' })

-- Make shell scrips executable
vim.keymap.set('n', '<leader>x', '<cmd>silent !chmod +x %<CR>', { desc = 'Make shell script executable' })

-- Clear highlight with Esc
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear highlight with Esc' })

-- Yank to system with C-y
vim.keymap.set({ 'n', 'v' }, '<C-y>', [["+y]], { desc = 'Yank to system with C-y' })

-- Paste while preserving clip register
vim.keymap.set('x', '<leader>p', [["_dP]], { desc = 'Paste and preserve clipboard' })

-- Delete while preserving clip register
vim.keymap.set({ 'n', 'v' }, '<leader>D', [["_d]], { desc = 'Delete and preserve clipboard' })

-- Diagnostic QFlist keymaps
vim.keymap.set('n', '<leader>qo', vim.diagnostic.setloclist, { desc = '[Q]uickfix buffer list [O]pen' })
vim.keymap.set('n', '<leader>Qo', vim.diagnostic.setqflist, { desc = '[Q]uickfix global list [O]pen' })

-- Diagnostic QFlist next keymap
vim.keymap.set('n', '<leader>qn', function()
  if vim.fn.getloclist(0, { size = 0 }).size > 0 then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, 'lnext')
  elseif vim.fn.getqflist({ size = 0 }).size > 0 then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, 'cnext')
  end
end, { desc = '[Q]uickfix list [N]ext' })

-- Diagnostic QFlist prev keymap
vim.keymap.set('n', '<leader>qp', function()
  if vim.fn.getloclist(0, { size = 0 }).size > 0 then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, 'lprev')
  elseif vim.fn.getqflist({ size = 0 }).size > 0 then
    ---@diagnostic disable-next-line: param-type-mismatch
    pcall(vim.cmd, 'cprev')
  end
end, { desc = '[Q]uickfix list [P]revious' })

-- I use vim-tmux-navigator now.
-- Move from on vim split to another
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- I use vim-tmux-navigator now.
-- Use C-p to switch to previous pane.
-- vim.keymap.set({ 'n', 't' }, '<C-p>', '<Cmd>wincmd p<CR>', { desc = 'Switch to previous pane' })

-- Now using Tmux. Need to figure out how to do this with Tmux.
-- Create Zellij pane in git repo with Lazygit running
-- function ZellijLazygit()
--   local git_dir = vim.fn.finddir('.git', '.;')
--   local cwd_dir = vim.fn.getcwd()
--
--   if git_dir ~= '' then
--     os.execute(string.format('zellij action new-pane --floating --cwd "%s" -- lazygit', cwd_dir))
--     print('Starting Lazygit...')
--   else
--     print('Not in a git repo.')
--   end
-- end
--
-- Zellij pane keymap
-- vim.keymap.set('n', '<leader>lg', '<cmd>lua ZellijLazygit()<CR>', { desc = 'Zellij pane in git repo with Lazygit running', silent = true })
