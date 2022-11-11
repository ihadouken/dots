-------------------------------------------------
-- KEYBINDINGS
-------------------------------------------------

local function map(m, k, v)
	vim.keymap.set(m, k, v, { silent = true })
end

-- Mimic shell movements
map("i", "<C-E>", "<ESC>A")
map("i", "<C-A>", "<ESC>I")

-- Load recent sessions
map("n", "<leader>sl", "<CMD>SessionLoad<CR>")

-- Keybindings for telescope
map("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>")
map("n", "<leader>ff", "<CMD>Telescope find_files<CR>")
map("n", "<leader>fb", "<CMD>Telescope file_browser<CR>")
map("n", "<leader>fw", "<CMD>Telescope live_grep<CR>")
map("n", "<leader>ht", "<CMD>Telescope colorscheme<CR>")

-- SudaWrite
map("c", "ww", "<CMD>SudaWrite<CR>")

-- Goyo (focus mode)
map("n", "<leader>g", "<CMD>Goyo<CR>")

-- NerdTree
map("n", "<leader>nn", "<CMD>NERDTreeVCS<CR>")
map("n", "<leader>n.", "<CMD>NERDTreeFind<CR>")
map("n", "<leader>nf", "<CMD>NERDTreeFocus<CR>")
map("n", "<leader>nq", "<CMD>NERDTreeClose<CR>")
map("n", "<leader>nt", "<CMD>NERDTreeToggleVCS<CR>")
map("n", "<leader>nc", "<CMD>NERDTreeCWD<CR>")
map("n", "<leader>nr", "<CMD>NERDTreeRefreshRoot<CR>")

-- Disable arrow keys
map("n", "<Up>"   , "<Nop>")
map("n", "<Down>" , "<Nop>")
map("n", "<Left>" , "<Nop>")
map("n", "<Right>", "<Nop>")

map("i", "<Up>"   , "<Nop>")
map("i", "<Down>" , "<Nop>")
map("i", "<Left>" , "<Nop>")
map("i", "<Right>", "<Nop>")

-- Open terminal inside vim
map("n", "<Leader>tt", "<CMD>vnew term://zsh<CR>")

-- Split navigation (easy)
map("n", "<C-h>"    , "<C-w>h")
map("n", "<C-j>"    , "<C-w>j")
map("n", "<C-k>"    , "<C-w>k")
map("n", "<C-l>"    , "<C-w>l")
map("n", "<Leader>w", "<C-w>")

-- Splits resize (easy)
map("n", "<M-l>", "<CMD>vertical resize +3<CR>")
map("n", "<M-h>", "<CMD>vertical resize -3<CR>")
map("n", "<M-j>", "<CMD>resize +3<CR>")
map("n", "<M-k>", "<CMD>resize -3<CR>")

-- Toggle vertical/horizontal split
map("n", "<Leader>th", "<C-w>t<C-w>H")
map("n", "<Leader>tk", "<C-w>t<C-w>K")

-- Hot reload config
map("n", "<Leader>hrr", "<CMD>lua ReloadConfig()<CR>")

-- For vim's terminal buffer
map("t", "<ESC><ESC>", "<C-\\><C-n>")

-- Coc
map("n", "<Leader>ie", "<CMD>CocEnable<CR>")
map("n", "<Leader>id", "<CMD>CocDisable<CR>")
map("n", "<Leader>io", "<CMD>CocOutline<CR>")
map("n", "<Leader>ic", "<CMD>CocCommand<CR>")
