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
        init = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")
            local wk = require("which-key")
            wk.add({
                { "<Esc><Esc>", "<Esc>:nohlsearch<CR>", mode = "n", silent = true, hidden = true },
                { "<leader>ff", builtin.find_files, mode = "n", desc = "Find files" },
                { "<leader>fg", builtin.live_grep, mode = "n", desc = "Live grep" },
                { "<leader>fG", builtin.git_files, mode = "n", desc = "Git files" },
                { "<leader>fb", builtin.buffers, mode = "n", desc = "Buffers" },
                { "<leader>fB", telescope.extensions.file_browser.file_browser, mode = "n", desc = "File browser" },
                { "<leader>fo", builtin.oldfiles, mode = "n", desc = "Old files" },
                { "<leader>fh", builtin.help_tags, mode = "n", desc = "Help" },
            })
        end,
    },
}
