function Sdcv()
  local pickers = require('telescope.pickers')
  local finders = require('telescope.finders')
  local sorters = require('telescope.sorters')
  local previewers = require('telescope.previewers')
  local entry_display = require('telescope.pickers.entry_display')

  local cursor_word = vim.fn.expand('<cword>')

  -- Command to get the JSON output
  local input = { 'sdcv', '-n', '-j', '--data-dir=' .. vim.fn.expand('~/.config/nvim/stardict'), cursor_word }

  -- Run the command and get the JSON output
  local output = vim.fn.systemlist(table.concat(input, ' '))
  local parsed_output = vim.fn.json_decode(table.concat(output, ''))

  -- Extract 'dict' fields and store the full entries
  local entries = {}
  for _, entry in ipairs(parsed_output) do
    table.insert(entries, {
      dict = entry.dict,
      definition = entry.definition,
    })
  end

  -- Function to trim whitespace from both ends of a string
  local function trim(s)
    return s:match('^%s*(.-)%s*$')
  end

  -- Function to wrap text to a specific width
  local function wrap_text(text, width)
    local wrapped_lines = {}
    for _, line in ipairs(vim.split(text, '\n')) do
      line = trim(line)
      while #line > width do
        local wrap_pos = line:find(' ', width) or #line
        table.insert(wrapped_lines, trim(line:sub(1, wrap_pos)))
        line = trim(line:sub(wrap_pos + 1))
      end
      table.insert(wrapped_lines, line)
    end
    return wrapped_lines
  end

  -- Create a custom previewer
  local function custom_previewer()
    return previewers.new_buffer_previewer({
      define_preview = function(self, entry)
        local bufnr = self.state.bufnr
        local wrapped_definition = wrap_text(entry.value.definition, 40)
        vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, wrapped_definition)
        vim.bo[bufnr].filetype = 'txt'
      end,
    })
  end

  -- Create the display for each entry
  local displayer = entry_display.create({
    separator = ' ',
    items = {
      { width = 50 },
    },
  })

  local function make_display(entry)
    return displayer({
      entry.value.dict,
    })
  end

  local opts = {
    finder = finders.new_table({
      results = entries,
      entry_maker = function(entry)
        return {
          value = entry,
          display = make_display,
          ordinal = entry.dict,
        }
      end,
    }),
    sorter = sorters.get_generic_fuzzy_sorter(),
    previewer = custom_previewer(),
    results_title = cursor_word,
    prompt_title = 'Search Dictionaries',

    -- Attach custom mappings
    attach_mappings = function(prompt_bufnr, map)
      local function expand_preview()
        local entry = require('telescope.actions.state').get_selected_entry()
        if entry.preview then
          require('telescope.previewers').toggle_preview(picker)
        end
      end

      -- Expand preview on Enter key press
      map('i', '<CR>', expand_preview)
      map('n', '<CR>', expand_preview)

      return true
    end,
  }

  local picker = pickers.new(opts)
  picker:find()
end

-- Map the function to your desired keymap
vim.api.nvim_set_keymap('n', '<leader>st', ':lua Sdcv()<CR>', { desc = '[S]earch [T]erm under cursor in dictionary', noremap = true, silent = true })
