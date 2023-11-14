local status, packer = pcall(require, "packer")
if not status then
    print("Packer is not installed")
    return
end

-- Reloads Neovim after whenever you save plugins.lua --
vim.cmd([[
    augroup packer_user_config
      autocmd!
     autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup END
]])

packer.startup(function(use)
    -- Packer can manage itself --
    use("wbthomason/packer.nvim")

    -- Dashboard is a nice start screen for nvim --
    use("glepnir/dashboard-nvim")

    -- Telescope --
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use("nvim-telescope/telescope-file-browser.nvim")


    -- Productivity --
    -- use("vimwiki/vimwiki")
    -- use("jreybert/vimagit")
    -- use("nvim-orgmode/orgmode")

    -- UI --
    use("folke/which-key.nvim")
    use("nvim-lualine/lualine.nvim")

    -- Tim Pope Plugins --
    use("tpope/vim-surround")

    -- Syntax Highlighting and Colors --
    use("nvim-treesitter/nvim-treesitter")
    use("PotatoesMaster/i3-vim-syntax")
    use("kovetskiy/sxhkd-vim")
    use("vim-python/python-syntax")
    use("ap/vim-css-color")

    -- Junegunn Choi Plugins --
    use("junegunn/goyo.vim")
    use("junegunn/limelight.vim")
    use("junegunn/vim-emoji")

    -- Colorschemes --
    use("RRethy/nvim-base16")
    use("kyazdani42/nvim-palenight.lua")

    -- Other stuff --
    use("frazrepo/vim-rainbow")

    -- Vim needs sudo --
    use("lambdalisue/suda.vim")

    -- Advanced commenting/uncommenting --
    use {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    if packer_bootstrap then
        packer.sync()
    end
end)
