-- For `plugins/markview.lua` users.
return {
  'OXY2DEV/markview.nvim',
  lazy = false,

  config = function()
    local presets = require('markview.presets')
    require('markview').setup({

      preview = {
        -- hybrid_modes = { 'n' },
      },

      experimental = { check_rtp = false },

      markdown = {
        -- tables = presets.tables.rounded,
        -- horizontal_rules = presets.horizontal_rules.arrowed,
        -- headings = presets.headings.slanted,
      },

      checkboxes = {
        enable = true,

        checked = { text = '󰗠', hl = 'DiagnosticSignHint', scope_hl = 'DiagnosticSignHint' },
        unchecked = { text = '󰄰', hl = 'DiagnosticUnnecessary', scope_hl = 'DiagnosticUnnecessary' },

        ['>'] = { text = '', hl = 'DiagnosticSignInfo', scope_hl = 'DiagnosticSignInfo' },
        ['~'] = { text = '󰰱', hl = 'DiagnosticSignError', scope_hl = 'DiagnosticSignError' },
        ['!'] = { text = '󰀦', hl = 'DiagnosticSignWarn', scope_hl = 'DiagnosticSignWarn' },
      },
    })
  end,
}
