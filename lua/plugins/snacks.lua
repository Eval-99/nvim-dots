return {
  'folke/snacks.nvim',
  opts = {
    picker = {
      win = {
        input = {
          keys = {
            ['p'] = { 'focus_preview', mode = { 'n', 'x' } },
          },
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start

    -- Search Files
    { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
    { '<leader>sF', function() Snacks.picker.smart() end, desc = '[S]earch [F]iles (Smart)' },
    { '<leader>sn', function() Snacks.picker.files({ cwd = vim.fn.stdpath('config') }) end, desc = '[S]earch [N]eovim Files' },
    { '<leader>sl', function() Snacks.picker.files({ cwd = vim.fn.stdpath('data') }) end, desc = '[S]earch Neovim [L]azy Files' },
    { '<leader>/',  function() Snacks.picker.lines({ layout = { preset = 'select' } }) end, desc = '[/] Fuzzily search in current buffer' },
    { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },

    -- Git
    { '<leader>sgr', function() Snacks.picker.git_files() end, desc = '[S]earch [G]it [R]epo' },
    { '<leader>sgG', function() Snacks.picker.git_grep() end, desc = '[S]earch [G]it [G]rep' },
    { '<leader>sgs', function() Snacks.picker.git_status() end, desc = '[S]earch [G]it [S]tatus' },
    { '<leader>sgS', function() Snacks.picker.git_stash() end, desc = '[S]earch [G]it [S]tash' },
    { '<leader>sgb', function() Snacks.picker.git_branches() end, desc = '[S]earch [G]it [B]ranches' },
    { '<leader>sgl', function() Snacks.picker.git_log() end, desc = '[S]earch [G]it [L]og' },
    { '<leader>sgL', function() Snacks.picker.git_log_line() end, desc = '[S]earch [G]it [L]og (Line)' },
    { '<leader>sgd', function() Snacks.picker.git_diff() end, desc = '[S]earch [G]it [D]iff' },

    -- Grep
    { '<leader>sgg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
    { '<leader>s/',  function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Buffers' },
    { '<leader>sw',  function() Snacks.picker.grep_word() end, desc = '[S]earch Current [W]ord', mode = { 'n', 'x' } },

    -- Diagnostics
    { '<leader>sd',  function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
    { '<leader>sD',  function() Snacks.picker.diagnostics_buffer() end, desc = '[S]earch [D]iagnostics in Buffer' },

    -- Quickfix list and Loc list
    { '<leader>sq', function() Snacks.picker.qflist() end, desc = '[S]earch [Q]uickfix List' },
    { '<leader>sL', function() Snacks.picker.loclist() end, desc = '[S]each [L]ocation List' },

    -- Commands
    { '<leader>sc',  function() Snacks.picker.commands() end, desc = '[S] [C]ommands' },
    { '<leader>sC',  function() Snacks.picker.command_history() end, desc = '[S]earch [C]ommand History' },

    -- Search ETC
    { '<leader>sh',  function() Snacks.picker.help() end, desc = '[S]earch [H]elp Pages' },
    { '<leader>S/',  function() Snacks.picker.search_history() end, desc = '[S]earch [/] History' },
    { '<leader>sp', function() Snacks.picker.pickers() end, desc = '[S]earch [P]ickers' },
    { '<leader>ss',  function() Snacks.picker.resume() end, desc = '[S]earch Open [P]ickers and [S]elect' },
    { '<leader>sk',  function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
    { '<leader>si',  function() Snacks.picker.icons({ custom_sources = { kaomoji = 'https://raw.githubusercontent.com/Eval-99/snacks-picker-kaomoji/refs/heads/main/kaomoji.json' }}) end, desc = '[S]earch [I]cons' },
    { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Search buffers' },

    -- stylua: ignore end
  },
}
