local keyset = vim.keymap.set

-- Auto complete
function _G.check_back_space()
    local col = vim.fn.col('.') - 1
    return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
end

-- Use tab for intellisense navigation
local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
keyset("i", "<TAB>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()', opts)
keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

-- <CR> accepts selected completion
keyset("i", "<cr>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)

-- Use <c-j> to trigger snippets
keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
-- Use <c-space> to trigger completion.
keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})

-- Use `[g` and `]g` to navigate diagnostics
-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
keyset("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})

-- GoTo code navigation.
keyset("n", "gd", "<Plug>(coc-definition)", {silent = true})
keyset("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
keyset("n", "gi", "<Plug>(coc-implementation)", {silent = true})
keyset("n", "gr", "<Plug>(coc-references)", {silent = true})

-- Highlight the symbol and its references when holding the cursor.
vim.api.nvim_create_augroup("CocGroup", {})
vim.api.nvim_create_autocmd("CursorHold", {
    group = "CocGroup",
    command = "silent call CocActionAsync('highlight')",
    desc = "Highlight symbol under cursor on CursorHold"
})

-- Apply AutoFix to problem on the current line.
keyset("n", "<leader>if", "<Plug>(coc-fix-current)", opts)

-- Run the Code Lens action on the current line.
keyset("n", "<leader>il", "<Plug>(coc-codelens-action)", opts)

-- Add (Neo)Vim's native statusline support.
-- NOTE: Please see `:h coc-status` for integrations with external plugins that
-- provide custom statusline: lightline.vim, vim-airline.
vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")


-- Mappings for CoCList
-- code actions and coc stuff
---@diagnostic disable-next-line: redefined-local
local opts = {silent = true, nowait = true}
-- Show all diagnostics.
keyset("n", "<Leader>ila", ":<C-u>CocList diagnostics<cr>", opts)
-- Manage extensions.
keyset("n", "<Leader>ile", ":<C-u>CocList extensions<cr>", opts)
-- Show commands.
keyset("n", "<Leader>ilc", ":<C-u>CocList commands<cr>", opts)
-- Find symbol of current document.
keyset("n", "<Leader>ilo", ":<C-u>CocList outline<cr>", opts)
-- Search workspace symbols.
keyset("n", "<Leader>ils", ":<C-u>CocList -I symbols<cr>", opts)
-- Do default action for next item.
keyset("n", "<Leader>ij", ":<C-u>CocNext<cr>", opts)
-- Do default action for previous item.
keyset("n", "<Leader>ik", ":<C-u>CocPrev<cr>", opts)
-- Resume latest coc list.
keyset("n", "<Leader>ilr", ":<C-u>CocListResume<cr>", opts)
