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
    vim.keymap.set('n', '<leader>nc', function()
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

    -- stylua: ignore start

    -- Create a new note after asking for its title.
    vim.keymap.set('n', '<leader>nn', "<Cmd>ZkNew { title = vim.fn.input('Title: ') }<CR>", { noremap = true, silent = false, desc = 'ZK: New note' })

    -- Open notes.
    vim.keymap.set('n', '<leader>no', "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", { noremap = true, silent = false, desc = 'ZK: Open notes' })

    -- Open notes associated with the selected tags.
    vim.keymap.set('n', '<leader>nt', '<Cmd>ZkTags<CR>', { noremap = true, silent = false, desc = 'ZK: Search tags' })

    -- Open zk directory
    vim.keymap.set('n', '<leader>nC', '<Cmd>ZkCd<CR>', { noremap = true, silent = false, desc = 'ZK: Open ZK folder' })

    -- Search for the notes matching a given query.
    vim.keymap.set('n', '<leader>nf', "<Cmd>ZkNotes { sort = { 'modified' }, match = { vim.fn.input('Search: ') } }<CR>", { noremap = true, silent = false, desc = 'ZK: Search notes' })

    -- Search for the notes matching the current visual selection.
    vim.keymap.set('v', '<leader>nm', "<Cmd>'<,'>ZkMatch<CR>", { noremap = true, silent = false, desc = 'ZK: Search highlighted in notes' })

    -- Insert link
    vim.keymap.set('n', '<leader>ni', "<Cmd>ZkInsertLink<CR>", { noremap = true, silent = false, desc = 'ZK: Insert link' })

    -- Insert link at selection
    vim.keymap.set('v', '<leader>ni', "<Cmd>'<,'>ZkInsertLinkAtSelection<CR>", { noremap = true, silent = false, desc = 'ZK: Insert link at selected' })

    -- Create a new note in the same directory as the current buffer, using the current selection for title.
    vim.keymap.set('v', '<leader>ns', "<Cmd>'<,'>ZkNewFromTitleSelection { dir = vim.fn.expand('%:p:h') }<CR>", { noremap = true, silent = false, desc = 'ZK: New note with selected as title' })

    -- Create a new note in the same directory as the current buffer, using the current selection for note content and asking for its title.
    vim.keymap.set('v', '<leader>nS', "<Cmd>'<,'>ZkNewFromContentSelection { dir = vim.fn.expand('%:p:h'), title = vim.fn.input('Title: ') }<CR>", { noremap = true, silent = false, desc = 'ZK: New note with selected as contend' })

    -- Open notes linking to the current buffer.
    vim.keymap.set('n', '<leader>nb', '<Cmd>ZkBacklinks<CR>', { noremap = true, silent = false, desc = 'ZK: List backlinks' })

    -- Open notes linked by the current buffer.
    vim.keymap.set('n', '<leader>nl', '<Cmd>ZkLinks<CR>', { noremap = true, silent = false, desc = 'ZK: List local links' })

    -- stylua: ignore end
  end,
}
