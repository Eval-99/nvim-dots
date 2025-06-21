return {
  'obsidian-nvim/obsidian.nvim',
  version = '*',
  lazy = true,
  event = {
    -- stylua: ignore start
    'BufReadPre ' .. vim.fn.expand('~') .. '/Documents/Notes/zk/*.md',
    'BufNewFile ' .. vim.fn.expand('~') .. '/Documents/Notes/zk/*.md',
    -- stylua: ignore end
  },
  dependencies = {
    -- Required.
    'nvim-lua/plenary.nvim',

    -- see above for full list of optional dependencies ☝️
  },
  ---@module 'obsidian'
  ---@type obsidian.config.ClientOpts
  opts = {
    statusline = {
      enabled = true, -- turn it off
      format = ' {{backlinks}} backlinks    {{properties}} properties  󰧮 {{words}} words   {{chars}} chars', -- works like the template system
    },
    workspaces = {
      {
        name = 'main',
        path = '~/Documents/Notes/zk',
      },
    },
  },
}
