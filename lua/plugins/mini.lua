return {
  'echasnovski/mini.nvim',
  config = function()
    require('mini.ai').setup({ n_lines = 500 })

    -- Surround
    require('mini.surround').setup({
      custom_surroundings = {
        ['b'] = { output = { left = '\\textbf{', right = '}' } },
        ['i'] = { output = { left = '\\textit{', right = '}' } },
        ['q'] = { output = { left = '`', right = "'" } },
        ['Q'] = { output = { left = '``', right = "''" } },
      },

      n_lines = 20,
      silent = false,
      search_method = 'cover',
      highlight_duration = 500,
      respect_selection_type = false,
      mappings = {
        add = 'sa',
        delete = 'sd',
        find = 'sf',
        find_left = 'sF',
        highlight = 'sh',
        replace = 'sr',
        update_n_lines = 'sn',
        suffix_last = 'l',
        suffix_next = 'n',
      },
    })

    -- Move text blocks in visual mode
    require('mini.move').setup({
      mappings = {
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',
      },

      options = {
        reindent_linewise = true,
      },
    })

    -- Show keymaps
    local miniclue = require('mini.clue')
    miniclue.setup({
      triggers = {

        -- Leader triggers
        { mode = 'n', keys = '<Leader>' },
        { mode = 'x', keys = '<Leader>' },

        -- Built-in completion
        { mode = 'i', keys = '<C-x>' },

        -- `g` key
        { mode = 'n', keys = 'g' },
        { mode = 'x', keys = 'g' },

        -- Marks
        { mode = 'n', keys = "'" },
        { mode = 'n', keys = '`' },
        { mode = 'x', keys = "'" },
        { mode = 'x', keys = '`' },

        -- Registers
        { mode = 'n', keys = '"' },
        { mode = 'x', keys = '"' },
        { mode = 'i', keys = '<C-r>' },
        { mode = 'c', keys = '<C-r>' },

        -- Window commands
        { mode = 'n', keys = '<C-w>' },

        -- `z` key
        { mode = 'n', keys = 'z' },
        { mode = 'x', keys = 'z' },
      },

      clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
      },

      window = {
        config = { width = 'auto', border = 'rounded' },
      },
    })
  end,
}
