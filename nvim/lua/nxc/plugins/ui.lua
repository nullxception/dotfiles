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
            notifier = {
                top_down = false,
                margin = { bottom = 2 },
            },
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
