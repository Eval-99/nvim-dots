-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Nerd font
vim.g.have_nerd_font = true

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Enable mouse
vim.o.mouse = 'a'

-- Don't show the mode
vim.o.showmode = false

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
vim.opt.swapfile = false
vim.opt.backup = false

-- Case-insensitive searching
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Setup tabs and spaces
vim.opt.expandtab = true

-- Show whitespace
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- Quit with insaved files will open a confirmation menu
vim.o.confirm = true

-- Block cursor and blink
vim.o.guicursor =
  'n-v-c:block,i-ci-ve:block,r-cr:block,o:block,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175'

-- Termguicolors
vim.opt.termguicolors = true

-- Auto change dir
vim.o.autochdir = true

-- Have only 1 statusline at all times
vim.o.laststatus = 3

-- No splash screen
vim.cmd([[set shm+=I]])

-- Minimal netrw
vim.cmd([[let g:netrw_banner = 0]])
