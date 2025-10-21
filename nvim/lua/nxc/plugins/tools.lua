---@module "lazy"
---@type LazySpec
return {
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaRead", "SudaWrite" },
    },
    {
        "wakatime/vim-wakatime",
        event = { "BufReadPost", "BufWritePost" },
        opts = {
            plugin_name = "neovim-wakatime", -- fix editor = 'unknown' issues on wakapi
            heartbeat_frequency = 1,
        },
    },
    {
        "vyfor/cord.nvim",
        event = "VeryLazy",
        build = ":Cord update",
        ---@module "cord"
        ---@type CordConfig
        opts = {
            text = {
                workspace = "In /Library/****",
            },
        },
    },
}
