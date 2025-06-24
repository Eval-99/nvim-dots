return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('gruvbox').setup({
      undercurl = false,
      underline = true,
      bold = true,
      italic = {
        strings = false,
        emphasis = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true,
      contrast = '',
      palette_overrides = {},
      dim_inactive = false,
      transparent_mode = false,

      overrides = {
        Normal = { bg = '#1d2122' },

        SignColumn = { link = 'Normal' },

        GruvboxRedSign = { bg = '' },
        GruvboxBlueSign = { bg = '' },
        GruvboxAquaSign = { bg = '' },
        GruvboxGreenSign = { bg = '' },
        GruvboxOrangeSign = { bg = '' },
        GruvboxPurpleSign = { bg = '' },
        GruvboxYellowSign = { bg = '' },
        GruvboxRedUnderline = { fg = '#1d2122', bg = '#fb4934', bold = true },
        GruvboxYellowUnderline = { fg = '#1d2122', bg = '#fabd2f', bold = true },
        GruvboxAquaUnderline = { fg = '#1d2122', bg = '#8ec07c', bold = true },
        GruvboxBlueUnderline = { fg = '#1d2122', bg = '#83a598', bold = true },
        GruvboxPurpleUnderline = { fg = '#1d2122', bg = '#d3869b', bold = true },

        WinSeparator = { fg = '#ebdbb2', bg = '' },

        Search = { fg = '#689d6a', bg = '' },
        IncSearch = { fg = '#fb4934', bg = '' },

        -- I control these highlight groups manually from within the lsp config.
        SpellBad = { fg = '', bg = '' },
        SpellCap = { fg = '', bg = '' },
        SpellRare = { fg = '', bg = '' },
        SpellLocal = { fg = '', bg = '' },
      },
    })

    -- Set dark mode
    vim.o.background = 'dark'

    -- Set up transparent background
    function ThemeOpacity(color)
      color = color or 'gruvbox'
      vim.cmd.colorscheme(color)

      vim.api.nvim_set_hl(0, 'Normal', { bg = 'none' })
      vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
    end

    ThemeOpacity()
  end,
}
