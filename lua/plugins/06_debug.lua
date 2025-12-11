return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    { 'theHamsta/nvim-dap-virtual-text', opts = {} },

    -- Debug server plugin
    'leoluz/nvim-dap-go',
    'mfussenegger/nvim-dap-python',

    -- Minimal DAP UI
    {
      'igorlfs/nvim-dap-view',
      ---@module 'dap-view'
      ---@type dapview.Config
      opts = {
        winbar = {
          controls = {
            enabled = true,
          },
        },
        windows = {
          terminal = {
            position = 'right',
          },
        },
        help = {
          border = 'rounded',
        },
        auto_toggle = true,
        follow_tab = true,
      },
    },
  },

  -- stylua: ignore start
  keys = {
    { '<leader>dB', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = 'Debug: Set Breakpoint Condition' },
    { '<leader>db', function() require('dap').toggle_breakpoint() end, desc = 'Debug: Toggle Breakpoint' },
    { '<leader>dc', function() require('dap').continue() end, desc = 'Debug: Start/Continue' },
    { '<leader>da', function() require('dap').continue({ before = get_args }) end, desc = 'Debug: Continue with Args' },
    { '<leader>dC', function() require('dap').run_to_cursor() end, desc = 'Debug: Run to Cursor' },
    { '<leader>dg', function() require('dap').goto_() end, desc = 'Debug: Go to Line (No Execute)' },
    { '<leader>di', function() require('dap').step_into() end, desc = 'Debug: Step Into' },
    { '<leader>dj', function() require('dap').down() end, desc = 'Debug: Down' },
    { '<leader>dk', function() require('dap').up() end, desc = 'Debug: Up' },
    { '<leader>dl', function() require('dap').run_last() end, desc = 'Debug: Run Last' },
    { '<leader>do', function() require('dap').step_out() end, desc = 'Debug: Step Out' },
    { '<leader>dO', function() require('dap').step_over() end, desc = 'Debug: Step Over' },
    { '<leader>dP', function() require('dap').pause() end, desc = 'Debug: Pause' },
    { '<leader>dr', function() require('dap').repl.toggle() end, desc = 'Debug: Toggle REPL' },
    { '<leader>ds', function() require('dap').session() end, desc = 'Debug: Session' },
    { '<leader>dt', function() require('dap').terminate() end, desc = 'Debug: Terminate' },
    { '<leader>dw', function() require('dap.ui.widgets').hover() end, desc = 'Debug: Widgets' },
  },
  -- stylua: ignore end

  config = function()
    require('mason-nvim-dap').setup({
      automatic_installation = true,
      handlers = {},

      -- Server ensure installed
      ensure_installed = {
        'delve',
        'debugpy',
        'codelldb',
        'local-lua-debugger-vscode',
      },
    })

    -- Change breakpoint icons
    vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#fb4934' })
    vim.api.nvim_set_hl(0, 'DapStop', { fg = '#fabd2f' })
    local breakpoint_icons = vim.g.have_nerd_font
        and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
      or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
    for type, icon in pairs(breakpoint_icons) do
      local tp = 'Dap' .. type
      local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
      vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
    end

    -- Debug server plugin setup
    require('dap-go').setup({
      delve = {
        detached = vim.fn.has('win32') == 0,
      },
    })
    require('dap-python').setup('~/.local/share/nvim/mason/packages/debugpy/debugpy-adapter')
  end,
}
