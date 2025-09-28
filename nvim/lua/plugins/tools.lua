---@module "lazy"
---@type LazySpec
return {
    {
        "lambdalisue/suda.vim",
        cmd = { "SudaRead", "SudaWrite" },
    },
    {
        "wakatime/vim-wakatime",
        dependencies = { "folke/snacks.nvim" },
        event = { "BufReadPost", "BufWritePost" },
        cond = function()
            local home = vim.env.HOME or os.getenv("HOME")
            local cfg = vim.fs.joinpath(home, ".wakatime.cfg")
            return vim.uv.fs_stat(cfg) ~= nil
        end,
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
