return {
  'zk-org/zk-nvim',
  config = function()
    require('zk').setup({
      picker = 'telescope',
    })

    vim.env.ZK_NOTEBOOK_DIR = '~/Documents/Notes/zk'

    -- Open notes with the enter key and go back to prev buffer only on markdown files.
    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'markdown',
      callback = function()
        vim.keymap.set('n', '<CR>', '<Cmd>lua vim.lsp.buf.definition()<CR>', { noremap = true, silent = false, desc = 'ZK: Follow link' })
        vim.keymap.set('n', '<BS>', '<Cmd>bprevious<CR>', { noremap = true, silent = false, desc = 'ZK: Prev buffer in markdown' })
      end,
    })

    -- Toggle markdown checkboxes
    vim.keymap.set('n', '<leader>zc', function()
      local line = vim.api.nvim_get_current_line()
      local states = { '[ ]', '[x]', '[>]', '[~]', '[!]' }
      local s, e = line:find('%[.?.?%]')

      if s and e then
        local current = line:sub(s, e)
        local next_state = '[ ]' -- default if not found

        for i, state in ipairs(states) do
          if state == current then
            next_state = states[(i % #states) + 1]
            break
          end
        end

        local new_line = line:sub(1, s - 1) .. next_state .. line:sub(e + 1)
        vim.api.nvim_set_current_line(new_line)
      end
    end, { desc = 'ZK: Toggle checkbox state' })

    -- local opts = { noremap = true, silent = false }
    --
    -- -- stylua: ignore start
    -- -- Create a new note after asking for its title.
    -- vim.api.nvim_set_keymap('n', '<leader>zn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { noremap = true, silent = false, desc = '' })
    --
    -- -- Open notes.
    -- vim.api.nvim_set_keymap('n', '<leader>zo', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { noremap = true, silent = false, desc = '' })
    -- -- Open notes associated with the selected tags.
    -- vim.api.nvim_set_keymap('n', '<leader>zt', '<Cmd>ZkTags<CR>', { noremap = true, silent = false, desc = '' })
    --
    -- -- Search for the notes matching a given query.
    -- vim.api.nvim_set_keymap('n', '<leader>zf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", { noremap = true, silent = false, desc = '' })
    -- -- Search for the notes matching the current visual selection.
    -- vim.api.nvim_set_keymap('v', '<leader>zf', ":'<,'>ZkMatch<CR>", { noremap = true, silent = false, desc = '' })
    --
    -- -- Create a new note in the same directory as the current buffer, using the current selection for title.
    -- map('v', '<leader>znt', ":'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { noremap = true, silent = false, desc = '' })
    -- -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    -- map('v', '<leader>znc', ":'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { noremap = true, silent = false, desc = '' })
    --
    -- -- Open notes linking to the current buffer.
    -- map('n', '<leader>zb', '<Cmd>ZkBacklinks<CR>', { noremap = true, silent = false, desc = '' })
    -- -- Alternative for backlinks using pure LSP and showing the source context.
    -- --map('n', '<leader>zb', '<Cmd>lua vim.lsp.buf.references()<CR>', { noremap = true, silent = false, desc = '' })
    -- -- Open notes linked by the current buffer.
    -- map('n', '<leader>zl', '<Cmd>ZkLinks<CR>', { noremap = true, silent = false, desc = '' })
    -- -- stylua: ignore end
  end,
}
