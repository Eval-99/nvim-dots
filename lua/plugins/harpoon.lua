return {
  'theprimeagen/harpoon',
  config = function()
    local mark = require('harpoon.mark')
    local ui = require('harpoon.ui')

    vim.keymap.set('n', '<leader>a', mark.add_file, { desc = 'Harpoon file' })
    vim.keymap.set('n', '<leader>e', ui.toggle_quick_menu, { desc = 'Harpoon menu' })

    vim.keymap.set('n', '<leader>1', function()
      ui.nav_file(1)
    end, { desc = 'Go to 1st Harpooned file' })
    vim.keymap.set('n', '<leader>2', function()
      ui.nav_file(2)
    end, { desc = 'Go to 2nd Harpooned file' })
    vim.keymap.set('n', '<leader>3', function()
      ui.nav_file(3)
    end, { desc = 'Go to 3rd Harpooned file' })
    vim.keymap.set('n', '<leader>4', function()
      ui.nav_file(4)
    end, { desc = 'Go to 4th Harpooned file' })
  end,
}
