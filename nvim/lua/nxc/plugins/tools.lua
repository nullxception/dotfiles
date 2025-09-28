---@module "lazy"
---@type LazySpec
return {
    "lambdalisue/suda.vim",
    {
        "wakatime/vim-wakatime",
        lazy = true,
        event = { "BufReadPost", "BufWritePost" },
        opts = {
            plugin_name = "neovim-wakatime", -- fix editor = 'unknown' issues on wakapi
            heartbeat_frequency = 1,
        },
    },
    {
        "vyfor/cord.nvim",
        lazy = true,
        event = { "BufReadPost", "BufWritePost" },
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
