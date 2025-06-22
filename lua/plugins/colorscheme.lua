return {
  'ellisonleao/gruvbox.nvim',
  priority = 1000,
  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require('gruvbox').setup({
      undercurl = true,
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
        GruvboxGreenSign = { bg = '' },
        GruvboxOrangeSign = { bg = '' },
        GruvboxPurpleSign = { bg = '' },
        GruvboxYellowSign = { bg = '' },
        GruvboxRedSign = { bg = '' },
        GruvboxBlueSign = { bg = '' },
        GruvboxAquaSign = { bg = '' },

        WinSeparator = { fg = '#ebdbb2', bg = '' },
        Search = { fg = '#689d6a', bg = '' },
        IncSearch = { fg = '#fb4934', bg = '' },

        -- GruvboxRedUnderline = { fg = '#1d2122', bg = '#fb4934', bold = true },
        -- GruvboxYellowUnderline = { fg = '#1d2122', bg = '#fabd2f', bold = true },
        -- GruvboxAquaUnderline = { fg = '#1d2122', bg = '#8ec07c', bold = true },
        -- GruvboxBlueUnderline = { fg = '#1d2122', bg = '#83a598', bold = true },
      },
    })

    -- Clear spell highlight groups
    vim.api.nvim_set_hl(0, 'SpellBad', {})
    vim.api.nvim_set_hl(0, 'SpellCap', {})
    vim.api.nvim_set_hl(0, 'SpellRare', {})
    vim.api.nvim_set_hl(0, 'SpellLocal', {})

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
