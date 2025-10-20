---@module "lazy"
---@type LazySpec
return {
    "nvim-lua/popup.nvim",
    {
        "folke/snacks.nvim",
        priority = 1000,
        ---@module "snacks"
        ---@type snacks.Config
        opts = {
            picker = {},
        },
    },
    {
        "nvim-mini/mini.icons",
        version = false,
        init = function()
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },
    {
        "rcarriga/nvim-notify",
        priority = 999,
        ---@module "notify"
        ---@type notify.Config
        opts = {
            merge_duplicates = true,
            render = "wrapped-compact",
            stages = "static",
            timeout = 2500,
            top_down = false,
        },
        init = function()
            vim.notify = require("notify")
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "tokyonight",
                globalstatus = true,
            },
        },
    },
    {
        "nvim-mini/mini.indentscope",
        version = false,
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "dashboard",
                    "fzf",
                    "help",
                    "lazy",
                    "mason",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
