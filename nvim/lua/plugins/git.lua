---@module "lazy"
---@type LazySpec
return {
    {
        "tpope/vim-fugitive",
        event = { "CmdlineEnter" },
    },

    "sindrets/diffview.nvim",
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        ---@module "neogit"
        ---@type NeogitConfig
        opts = {
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
