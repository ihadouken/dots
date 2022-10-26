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
map("n", "<Leader>tt", "<CMD>vnew term://bash<CR>")

-- Split navigation (easy)
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Splits resize (easy)
map("n", "<C-S-k>", "vertical resize +3<CR>")
map("n", "<C-S-j>", "vertical resize -3<CR>")
map("n", "<C-S-l>", "resize +3<CR>")
map("n", "<C-S-h>", "resize -3<CR>")

-- Toggle vertical/horizontal split
map("n", "<Leader>th", "<C-w>t<C-w>H")
map("n", "<Leader>tk", "<C-w>t<C-w>K")
