local g = vim.g
local o = vim.o
local opt = vim.opt

-- vim.cmd('syntax on')
vim.api.nvim_command('filetype plugin indent on')

o.t_Co = 256
g.nocompatible = true

-- Do not save when switching buffers
o.hidden = true

-- Decrease update time
o.timeoutlen = 500
o.updatetime = 200

-- Number of screen lines to keep above and below the cursor
o.scrolloff = 8

-- Better editor UI
o.number = true
o.numberwidth = 2
o.relativenumber = true
o.cursorline = false
vim.cmd([[set noshowmode]])

-- Better editing experience
o.expandtab = true
o.smarttab = true
o.cindent = true
o.autoindent = true
o.wrap = true
o.textwidth = 300
o.tabstop = 4
o.shiftwidth = 4
o.softtabstop = -1 -- If negative, shiftwidth value is used
o.list = true
o.listchars = "trail:·,nbsp:◇,tab:→ ,extends:▸,precedes:◂"
-- o.listchars = 'eol:¬,space:·,lead: ,trail:·,nbsp:◇,tab:→-,extends:▸,precedes:◂,multispace:···⬝,leadmultispace:│   ,'
-- o.formatoptions = 'qrn1'

-- Makes neovim and host OS clipboard play nicely with each other
o.clipboard = "unnamedplus"

-- Case insensitive searching UNLESS /C or capital in search
o.ignorecase = true
o.smartcase = true

-- Undo and backup options
o.backup = false
o.writebackup = false
o.undofile = true
o.undodir = os.getenv("XDG_CACHE_HOME") .. "/nvim/undo"
os.execute("mkdir -p " .. o.undodir)
o.swapfile = false
-- o.backupdir = '/tmp/'
-- o.directory = '/tmp/'

-- Remember 50 items in commandline history
o.history = 50

-- Better buffer splitting
o.splitright = true
o.splitbelow = true

-- Preserve view while jumping
-- BUG This option causes an error!
-- o.jumpoptions = 'view'

-- BUG: this won't update the search count after pressing `n` or `N`
-- When running macros and regexes on a large file, lazy redraw tells neovim/vim not to draw the screen
-- o.lazyredraw = true

-- Better folds (don't fold by default)
-- o.foldmethod = 'indent'
-- o.foldlevelstart = 99
-- o.foldnestmax = 3
-- o.foldminlines = 1
--
opt.mouse = "a"

-- Map <leader> to space
g.mapleader = " "
g.maplocalleader = " "

-- set title
o.title = true

-- templates
vim.cmd([[autocmd BufNewFile *.c 0r ~/Templates/source.c]])
vim.cmd([[autocmd BufNewFile *.sh 0r ~/Templates/script.sh]])
vim.cmd([[autocmd BufNewFile *.html 0r ~/Templates/skeleton.html]])
vim.cmd([[autocmd BufNewFile *.py 0r ~/Templates/source.py]])

-- other stuff
g.python_highlight_all = 1
