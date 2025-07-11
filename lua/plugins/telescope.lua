return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      build = 'make',

      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    { 'allaman/emoji.nvim', opts = {} },
    { '2kabhishek/nerdy.nvim', dependencies = { 'folke/snacks.nvim' } },
  },
  config = function()
    -- Help menu Insert mode: <c-/>
    -- Help menu Normal mode: ?
    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    })

    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')
    pcall(require('telescope').load_extension, 'nerdy')
    pcall(require('telescope').load_extension, 'emoji')

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
    vim.keymap.set('n', '<leader>sr', builtin.git_files, { desc = '[S]earch Git [R]epo' })
    vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    vim.keymap.set('n', '<leader>sw', builtin.grep_string, { desc = '[S]earch Current [W]ord' })
    vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
    vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    vim.keymap.set('n', '<leader>sp', builtin.resume, { desc = '[S]earch Open [P]ickers' })
    vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Search buffers' })
    vim.keymap.set('n', '<leader>se', require('telescope').load_extension('emoji').emoji, { desc = '[S]earch [E]moji' })
    vim.keymap.set('n', '<leader>sm', '<CMD>Emoji kaomoji-by-group<CR>', { desc = '[S]earch Kao[m]oji' })
    vim.keymap.set('n', '<leader>si', '<CMD>Telescope nerdy<CR>', { desc = '[S]earch Nerd Font [I]con' })

    vim.keymap.set('n', '<leader>/', function()
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown({
        previewer = false,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })

    vim.keymap.set('n', '<leader>s/', function()
      builtin.live_grep({
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      })
    end, { desc = '[S]earch [/] in Open Files' })

    vim.keymap.set('n', '<leader>sn', function()
      builtin.find_files({ cwd = vim.fn.stdpath('config'), file_ignore_patterns = { 'stardict/', 'lazy%-lock%.json' } })
    end, { desc = '[S]earch [N]eovim Files' })

    vim.keymap.set('n', '<leader>sl', function()
      builtin.find_files({ cwd = vim.fs.joinpath(vim.fn.stdpath('data'), 'lazy') })
    end, { desc = '[S]earch Neovim [L]azy Files' })
  end,
}
