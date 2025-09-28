---@module "lazy"
---@type LazySpec
return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        ---@module "which-key"
        ---@type wk.Opts
        opts = {
            win = {
                border = "rounded",
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps",
            },
        },
    },
}
