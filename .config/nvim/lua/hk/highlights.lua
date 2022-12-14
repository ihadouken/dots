-------------------------------------------------
-- COLORSCHEMES
-------------------------------------------------

-- Uncomment just ONE of the following colorschemes!
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-dracula')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-gruvbox-dark-medium')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-monokai')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-nord')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-oceanicnext')
local ok, _ = pcall(vim.cmd, "colorscheme base16-onedark")
-- local ok, _ = pcall(vim.cmd, 'colorscheme palenight')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-dark')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-solarized-light')
-- local ok, _ = pcall(vim.cmd, 'colorscheme base16-tomorrow-night')

-- Highlight the region on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = num_au,
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
	end,
})

function DoomOne()
    vim.cmd([[
    highlight Normal           guifg=#dfdfdf ctermfg=15   guibg=#282c34 ctermbg=none  cterm=none
    highlight LineNr           guifg=#5b6268 ctermfg=8    guibg=#282c34 ctermbg=none  cterm=none
    highlight CursorLineNr     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
    highlight VertSplit        guifg=#1c1f24 ctermfg=0    guifg=#5b6268 ctermbg=8     cterm=none
    highlight Statement        guifg=#98be65 ctermfg=2    guibg=none    ctermbg=none  cterm=none
    highlight Directory        guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
    highlight StatusLine       guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
    highlight StatusLineNC     guifg=#202328 ctermfg=7    guifg=#5b6268 ctermbg=8     cterm=none
    highlight NERDTreeClosable guifg=#98be65 ctermfg=2
    highlight NERDTreeOpenable guifg=#5b6268 ctermfg=8
    highlight Comment          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=italic
    highlight Constant         guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
    highlight Special          guifg=#51afef ctermfg=4    guibg=none    ctermbg=none  cterm=none
    highlight Identifier       guifg=#5699af ctermfg=6    guibg=none    ctermbg=none  cterm=none
    highlight PreProc          guifg=#c678dd ctermfg=5    guibg=none    ctermbg=none  cterm=none
    highlight String           guifg=#3071db ctermfg=12   guibg=none    ctermbg=none  cterm=none
    highlight Number           guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
    highlight Function         guifg=#ff6c6b ctermfg=1    guibg=none    ctermbg=none  cterm=none
    highlight Visual           guifg=#dfdfdf ctermfg=1    guibg=#1c1f24 ctermbg=none  cterm=none
    highlight MatchParen gui=bold guibg=#cfbfaf guifg=#666666 cterm=bold ctermbg=NONE
    ]])
end

--DoomOne()
