return {
  'rachartier/tiny-inline-diagnostic.nvim',
  event = 'VeryLazy',
  priority = 1000,
  config = function()
    vim.diagnostic.config({ virtual_text = false })
    require('tiny-inline-diagnostic').setup({
      preset = 'modern',
      transparent_bg = true,
      transparent_cursorline = false,

      hi = {
        error = 'DiagnosticError', -- Highlight group for error messages
        warn = 'DiagnosticWarn', -- Highlight group for warning messages
        info = 'DiagnosticInfo', -- Highlight group for informational messages
        hint = 'DiagnosticHint', -- Highlight group for hint or suggestion messages
        arrow = 'NonText', -- Highlight group for diagnostic arrows
        background = 'CursorLine',
        mixing_color = 'None',
      },

      options = {
        show_source = {
          enabled = true,
          if_many = false,
        },

        use_icons_from_diagnostic = false,
        set_arrow_to_diag_color = false,
        add_messages = true,
        throttle = 20,
        softwrap = 30,

        multilines = {
          enabled = false,
          always_show = false,
        },

        -- Display all diagnostic messages on the cursor line
        show_all_diags_on_cursorline = false,

        -- Enable diagnostics in Insert mode
        -- If enabled, it is better to set the `throttle` option to 0 to avoid visual artifacts
        enable_on_insert = false,

        -- Enable diagnostics in Select mode (e.g when auto inserting with Blink)
        enable_on_select = false,

        overflow = {
          -- Manage how diagnostic messages handle overflow
          -- Options:
          -- "wrap" - Split long messages into multiple lines
          -- "none" - Do not truncate messages
          -- "oneline" - Keep the message on a single line, even if it's long
          mode = 'wrap',

          -- Trigger wrapping to occur this many characters earlier when mode == "wrap".
          -- Increase this value appropriately if you notice that the last few characters
          -- of wrapped diagnostics are sometimes obscured.
          padding = 0,
        },

        -- Configuration for breaking long messages into separate lines
        break_line = {
          -- Enable the feature to break messages after a specific length
          enabled = false,

          -- Number of characters after which to break the line
          after = 30,
        },

        -- Custom format function for diagnostic messages
        -- Example:
        -- format = function(diagnostic)
        --     return diagnostic.message .. " [" .. diagnostic.source .. "]"
        -- end
        format = nil,

        virt_texts = {
          -- Priority for virtual text display
          priority = 2048,
        },

        -- Filter diagnostics by severity
        -- Available severities:
        -- vim.diagnostic.severity.ERROR
        -- vim.diagnostic.severity.WARN
        -- vim.diagnostic.severity.INFO
        -- vim.diagnostic.severity.HINT
        severity = {
          vim.diagnostic.severity.ERROR,
          vim.diagnostic.severity.WARN,
          vim.diagnostic.severity.INFO,
          vim.diagnostic.severity.HINT,
        },

        -- Events to attach diagnostics to buffers
        -- You should not change this unless the plugin does not work with your configuration
        overwrite_events = nil,
      },
      disabled_ft = {}, -- List of filetypes to disable the plugin
    })
  end,
}
