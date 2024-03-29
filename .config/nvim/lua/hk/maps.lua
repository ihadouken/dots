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
map("c", "ww<CR>", "<CMD>SudaWrite<CR>")

-- Goyo (focus mode)
map("n", "<leader>g", "<CMD>Goyo<CR>")

-- Open terminal inside vim
map("n", "<Leader>ot", "<CMD>new term://zsh<CR>")
map("n", "<Leader>oT", "<CMD>vnew term://zsh<CR>")

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
map("n", "<Leader>sh", "<C-w>t<C-w>H")
map("n", "<Leader>sv", "<C-w>t<C-w>K")

-- Hot reload config
map("n", "<Leader>r", "<CMD>lua ReloadConfig()<CR>")

-- For vim's terminal buffer
map("t", "<ESC><ESC>", "<C-\\><C-n>")

-- Tabs
map("n", "<Leader>tn", "<CMD>tabnew<CR>")
map("n", "<Leader>t.", "<CMD>tabnext<CR>")
map("n", "<Leader>t,", "<CMD>tabprevious<CR>")
map("n", "<Leader>tc", "<CMD>tabclose<CR>")
map("n", "<Leader>tl", "<CMD>tabs<CR>")
map("n", "<Leader>t0", "<CMD>tabFirst<CR>")
map("n", "<Leader>t$", "<CMD>tabLast<CR>")

-- Redo last command line.
map("n", "<C-p>", "@:")
-- Redo last command line and skip "press any key" prompt after completion.
map("n", "<Leader>p", "@:<CR>")

-- Quick write
map("n", "ZW", "<CMD>w<CR>")
