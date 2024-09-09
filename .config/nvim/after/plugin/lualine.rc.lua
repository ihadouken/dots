require('lualine').setup {
    options = {
        theme = 'base16'
        -- theme = 'codedark'
        -- globalstatus = true
    },
    disabled_buftypes = {
        'packer',
    }
}

-- Hide lualine when goyo is active
vim.cmd([[autocmd User GoyoEnter lua require('lualine').hide()]])
