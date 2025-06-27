return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    'ribru17/blink-cmp-spell',
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        if vim.fn.has('win32') == 1 or vim.fn.executable('make') == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = function()
        require('snippets.latex')
      end,
    },
    'folke/lazydev.nvim',
  },
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    -- Main keymaps
    keymap = {
      preset = 'default',
      ['<C-y>'] = { 'show', 'show_documentation', 'hide_documentation' },
      ['<C-e>'] = { 'hide' },
      ['<C-space>'] = { 'select_and_accept' },
    },

    -- Command mode keymaps
    cmdline = {
      keymap = {
        ['<Tab>'] = { 'show_and_insert', 'select_next' },
        ['<S-Tab>'] = { 'show_and_insert', 'select_prev' },

        ['<C-y>'] = { 'show', 'fallback' },

        ['<C-n>'] = { 'select_next', 'fallback' },
        ['<C-p>'] = { 'select_prev', 'fallback' },
        ['<C-space>'] = { 'select_and_accept' },
        ['<C-e>'] = { 'cancel' },
      },
    },

    appearance = {
      nerd_font_variant = 'normal',
    },

    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500, window = { border = 'rounded' } },
      ghost_text = { enabled = true },
      menu = {
        draw = {
          columns = {
            { 'label', 'label_description', gap = 1 },
            { 'kind_icon', 'kind', 'source_name' },
          },
        },
        border = 'rounded',
        winhighlight = 'Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpDocCursorLine,Search:None',
      },
    },

    sources = {
      default = { 'lsp', 'spell', 'buffer', 'path', 'snippets', 'lazydev', 'omni' },
      per_filetype = { sql = { 'dadbod', 'buffer', 'snippets' } },
      providers = {
        dadbod = { name = 'Dadbod', module = 'vim_dadbod_completion.blink' },
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        spell = { name = 'Spell', module = 'blink-cmp-spell', opts = {} },
        omni = {
          module = 'blink.cmp.sources.complete_func',
          enabled = function()
            return vim.bo.omnifunc ~= 'v:lua.vim.lsp.omnifunc'
          end,
          ---@type blink.cmp.CompleteFuncOpts
          opts = {
            complete_func = function()
              return vim.bo.omnifunc
            end,
          },
        },
      },
    },

    snippets = { preset = 'luasnip' },

    fuzzy = {
      implementation = 'lua',
      sorts = {
        function(a, b)
          local sort = require('blink.cmp.fuzzy.sort')
          if a.source_id == 'spell' and b.source_id == 'spell' then
            return sort.label(a, b)
          end
        end,
        'score',
        'kind',
        'label',
      },
    },

    signature = { enabled = false },
  },
}
