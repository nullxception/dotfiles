-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "windwp/nvim-autopairs",
    'lambdalisue/suda.vim',
    'tpope/vim-fugitive',
    {
        'folke/tokyonight.nvim',
        lazy = false,
        priority = 1000,
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make'
    },
    {
        'nvim-telescope/telescope.nvim',
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
            'nvim-telescope/telescope-fzf-native.nvim',
            'nvim-telescope/telescope-symbols.nvim',
        },
    },
    'nvim-telescope/telescope-file-browser.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "lua_ls",
                "vimls"
            }
        },
        dependencies = {
            { 
                "mason-org/mason.nvim",      
                opts = {
                    ensure_installed = { "prettier" },
                    ui = { border = "single" }
                }
            },
            "neovim/nvim-lspconfig",
        }
    },
    'hrsh7th/nvim-cmp',
    'hrsh7th/cmp-nvim-lsp',
    'L3MON4D3/LuaSnip',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lua',
    {
        "rcarriga/nvim-dap-ui",
        dependencies = {
            "mfussenegger/nvim-dap"
        }
    },
    {
        "akinsho/flutter-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'stevearc/dressing.nvim'
        },
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = {
            'nvim-tree/nvim-web-devicons',
            lazy = true
        },
    },
    {
        'glepnir/dashboard-nvim',
        event = 'VimEnter',
        dependencies = { { 'nvim-tree/nvim-web-devicons' } }
    }
})
