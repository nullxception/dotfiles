---@module "lazy"
---@type LazySpec
return {
    {
        "DrKJeff16/wezterm-types",
        lazy = true,
        version = false,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        ---@module "lazydev"
        ---@type lazydev.Config
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "wezterm-types", mods = { "wezterm" } },
            },
        },
    },
}
