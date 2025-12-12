return {
  'stevearc/oil.nvim',
  ---@module 'oil'
  ---@type oil.SetupOpts
  dependencies = { 'nvim-mini/mini.nvim' },
  lazy = false,
  config = function()
    local detail = false
    vim.keymap.set('n', '<leader>ol', '<CMD>Oil<CR>', { desc = 'Open Oil.nvim' })
    require('oil').setup({
      default_file_explorer = true,
      columns = {
        'icon',
      },
      buf_options = {
        buflisted = false,
        bufhidden = 'hide',
      },
      win_options = {
        wrap = false,
        signcolumn = 'no',
        cursorline = true,
        cursorcolumn = false,
        foldcolumn = '0',
        spell = false,
        list = false,
        conceallevel = 3,
        concealcursor = 'nvic',
      },
      delete_to_trash = true,
      skip_confirm_for_simple_edits = false,
      prompt_save_on_select_new_entry = true,
      cleanup_delay_ms = 2000,
      lsp_file_methods = {
        enabled = true,
        timeout_ms = 1000,
        autosave_changes = false,
      },
      constrain_cursor = 'editable',
      watch_for_changes = true,
      keymaps = {
        ['<CR>'] = 'actions.select',
        ['<BS>'] = { 'actions.parent', mode = 'n' },
        ['<leader>?'] = { 'actions.show_help', mode = 'n' },
        ['<leader>op'] = 'actions.preview',
        ['<leader>oc'] = { 'actions.cd', mode = 'n' },
        ['<leader>oq'] = { 'actions.close', mode = 'n' },
        ['<leader>oo'] = { 'actions.open_cwd', mode = 'n' },
        ['<leader>os'] = { 'actions.change_sort', mode = 'n' },
        ['<leader>ot'] = { 'actions.toggle_trash', mode = 'n' },
        ['<leader>o.'] = { 'actions.toggle_hidden', mode = 'n' },
        ['<leader>ov'] = { 'actions.select', opts = { vertical = true } },
        ['<leader>oh'] = { 'actions.select', opts = { horizontal = true } },
        ['<leader>od'] = {
          desc = 'Toggle file detail view',
          callback = function()
            detail = not detail
            if detail then
              require('oil').set_columns({ 'icon', 'permissions', 'size', 'mtime' })
            else
              require('oil').set_columns({ 'icon' })
            end
          end,
        },
      },
      use_default_keymaps = false,
      view_options = {
        show_hidden = false,
        is_hidden_file = function(name, bufnr)
          local m = name:match('^%.')
          return m ~= nil
        end,
        is_always_hidden = function(name, bufnr)
          return false
        end,
        -- Sort file names with numbers, "fast", true, or false.
        natural_order = 'fast',
        case_insensitive = false,
        sort = {
          { 'type', 'asc' },
          { 'name', 'asc' },
        },
        highlight_filename = function(entry, is_hidden, is_link_target, is_link_orphan)
          return nil
        end,
      },
      extra_scp_args = {},
      git = {
        add = function(path)
          return false
        end,
        mv = function(src_path, dest_path)
          return false
        end,
        rm = function(path)
          return false
        end,
      },
      -- Floating window in oil.open_float
      float = {
        padding = 2,
        max_width = 0,
        max_height = 0,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
        -- preview_split: Split direction: "auto", "left", "right", "above", "below".
        preview_split = 'auto',
        get_win_title = nil,
        override = function(conf)
          return conf
        end,
      },
      -- Preview window
      preview_win = {
        update_on_cursor_moved = true,
        preview_method = 'fast_scratch',
        disable_preview = function(filename)
          return false
        end,
        win_options = {},
      },
      -- Confirmation window
      confirmation = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = 0.9,
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        win_options = {
          winblend = 0,
        },
      },
      -- Floating progress window
      progress = {
        max_width = 0.9,
        min_width = { 40, 0.4 },
        width = nil,
        max_height = { 10, 0.9 },
        min_height = { 5, 0.1 },
        height = nil,
        border = 'rounded',
        minimized_border = 'none',
        win_options = {
          winblend = 0,
        },
      },
      -- SSH window
      ssh = {
        border = 'rounded',
      },
      -- Help window
      keymaps_help = {
        border = 'rounded',
      },
    })
  end,
}
