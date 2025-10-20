---@module "lazy"
---@type LazySpec
return {
    {
        "tpope/vim-fugitive",
        event = { "CmdlineEnter" },
    },
    {
        "sindrets/diffview.nvim",
        event = { "CmdlineEnter" },
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        ---@module "neogit"
        ---@type NeogitConfig
        opts = {
            integrations = {
                diffview = true,
                telescope = true,
            },
            telescope_sorter = function()
                return require("telescope").extensions.fzf.native_fzf_sorter()
            end,
        },
        keys = {
            {
                "<leader>ng",
                function()
                    require("neogit").open()
                end,
                desc = "Neogit",
            },
        },
    },
}
