return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'mason-org/mason.nvim', opts = { ui = { border = 'rounded' } } },
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',

    'saghen/blink.cmp',
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('config-lsp-attach', { clear = true }),
      callback = function(event)
        -- Clear some default LSP keymaps
        -- pcall(vim.keymap.del, 'n', 'grn') -- Rename
        -- pcall(vim.keymap.del, 'n', 'grr') -- References
        -- pcall(vim.keymap.del, 'n', 'gri') -- Implementation
        -- pcall(vim.keymap.del, { 'n', 'v' }, 'gra') -- Code Action

        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Execute a code action
        map('<leader>aw', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

        -- Rename the variable under your cursor.
        map('gR', vim.lsp.buf.rename, '[R]ename')

        -- Find references
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to the implementation
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to the definition
        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Jump to the declaration
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Fuzzy find symbols in current document.
        map('gO', require('telescope.builtin').lsp_document_symbols, '[O]pen Document Symbols')

        -- Fuzzy find the symbols in workspace.
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open [W]orkspace Symbols')

        -- Jump to type
        map('gy', require('telescope.builtin').lsp_type_definitions, '[G]oto T[y]pe Definition')

        -- Hover information
        map('K', function()
          vim.lsp.buf.hover({ border = 'rounded', max_height = 25, max_width = 120 })
        end, 'Hover information')

        -- Signature Help
        map('gs', function()
          vim.lsp.buf.signature_help({ border = 'rounded', max_height = 25, max_width = 120 })
        end, 'Signature Help')

        -- Signature Help Insert mode
        map('<C-s>', function()
          vim.lsp.buf.signature_help({ border = 'rounded', max_height = 25, max_width = 120 })
        end, 'Signature Help Insert Mode', 'i')

        -- This function resolves a difference between neovim nightly and stable
        ---@param client vim.lsp.Client
        ---@param method vim.lsp.protocol.Method
        ---@param bufnr? integer
        ---@return boolean
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has('nvim-0.11') == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- Toggle inlay hints
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>ti', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Diagnostic Config
    vim.diagnostic.config({
      severity_sort = true,
      float = { border = 'rounded', source = 'if_many' },
      underline = true,
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Toggle Ltex and Cspell language
    vim.opt.spelllang = { 'en_us' }
    function ToggleLtexLang()
      if vim.lsp.get_clients({ name = 'ltex_plus' })[1] ~= nil then
        local ltexServer = vim.lsp.get_clients({ name = 'ltex_plus' })[1]
        local ltexLang = ltexServer.config.settings.ltex.language
        if ltexLang == 'en-US' then
          ltexServer.config.settings.ltex.language = 'es'
          vim.opt.spelllang = { 'es' }
          vim.notify('LTeX language is Spanish', vim.log.levels.INFO)
        elseif ltexLang == 'es' then
          ltexServer.config.settings.ltex.language = 'en-US'
          vim.opt.spelllang = { 'en_us' }
          vim.notify('LTeX language is English', vim.log.levels.INFO)
        end
        ltexServer.notify('workspace/didChangeConfiguration', {
          settings = {
            ltex = ltexServer.config.settings.ltex,
          },
        })
      else
        local cspell = vim.opt.spelllang:get()[1]
        if cspell == 'en_us' then
          vim.opt.spelllang = { 'es' }
          print('Cspell language is Spanish')
        elseif cspell == 'es' then
          vim.opt.spelllang = { 'en_us' }
          print('Cspell language is English')
        end
      end
    end

    -- Enable and disable Cspell highlight groups
    -- This will not work with colorschemes other than gruvbox.nvim
    -- Look up what highlight groups Spell links to if using other colorscheme
    _G.highlight_enabled = _G.highlight_enabled or false
    function CspellHightlights()
      if _G.highlight_enabled == false then
        vim.api.nvim_set_hl(0, 'SpellBad', {})
        vim.api.nvim_set_hl(0, 'SpellCap', {})
        vim.api.nvim_set_hl(0, 'SpellRare', {})
        vim.api.nvim_set_hl(0, 'SpellLocal', {})
        _G.highlight_enabled = true
        print('Cspell highlights cleared')
      else
        vim.api.nvim_set_hl(0, 'SpellBad', { link = 'GruvboxRedUnderline' })
        vim.api.nvim_set_hl(0, 'SpellCap', { link = 'GruvboxBlueUnderline' })
        vim.api.nvim_set_hl(0, 'SpellRare', { link = 'GruvboxPurpleUnderline' })
        vim.api.nvim_set_hl(0, 'SpellLocal', { link = 'GruvboxAquaUnderline' })
        _G.highlight_enabled = false
        print('Cspell highlights enabled')
      end
    end

    -- Enable and disable Cspell
    function ToggleCSpell()
      local cspell_enabled = vim.opt.spell:get()
      if cspell_enabled == false then
        vim.opt.spell = true
        print('Cspell enabled')
      elseif cspell_enabled == true then
        vim.opt.spell = false
        print('Cspell disabled')
      end
    end

    -- Toggle keymaps
    vim.keymap.set('n', '<leader>cl', '<cmd>lua ToggleLtexLang()<cr>', { desc = '[C]hange Ltex [L]anguage' })
    vim.keymap.set('n', '<leader>cs', '<cmd>lua ToggleCSpell()<cr>', { desc = '[C]hange builtin neovim [S]pell state' })
    vim.keymap.set('n', '<leader>cc', '<cmd>lua CspellHightlights()<cr>', { desc = '[C]lear [C]spell highlight groups' })

    -- Install servers
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace',
            },
            -- Use Love2d
            -- diagnostics = { disable = { 'missing-fields' } },
            -- workspace = {
            --   userThirdParty = { '~/Code/lua/addons' },
            -- },
          },
        },
      },
      basedpyright = {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = 'basic',
            },
          },
        },
      },
      ltex_plus = {
        settings = {
          ltex = {
            enabled = {
              'bibtex',
              'context',
              'context.tex',
              'html',
              'latex',
              'markdown',
              'mdx',
              'typst',
              'asciidoc',
              'neorg',
              'org',
              'quarto',
              'restructuredtext',
              'rsweave',
              'gitcommit',
            },
            language = 'en-US',
            checkFrequency = 'edit',
            completionEnabled = true,
            diagnosticSeverity = 'information',
            setenceCacheSize = 2000,
            disabledRules = {
              ['en-US'] = { 'SPACE_BEFORE_PARENTHESIS' },
            },
            additionalRules = {
              enablePickyRules = true,
            },
          },
        },
        on_attach = function(client)
          -- Set update_in_insert to true for Ltex
          if client:supports_method('textDocument/publishDiagnostic') then
            local is_pull = false -- true for `textDocument/diagnostic`
            local ns = vim.lsp.diagnostic.get_namespace(client.id, is_pull)

            vim.diagnostic.config({
              update_in_insert = true,
            }, ns)
          end
        end,
      },
      ruff = { cmd = { '' } },
      texlab = {},
      clangd = {},
      zls = {},
      gopls = {},
      bashls = {},
      tinymist = {},
    }

    -- Install formaters
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua',
      'tex-fmt',
      'clang-format',
      'gofumpt',
      'goimports',
      'prettier',
      'shellcheck',
      'shfmt',
    })
    require('mason-tool-installer').setup({ ensure_installed = ensure_installed })

    require('mason-lspconfig').setup({
      ensure_installed = {},
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    })

    for k, v in pairs(servers) do
      vim.lsp.config(k, v)
    end
  end,
}
