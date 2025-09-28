local libfzf = require("core.libfzf")

---@module "lazy"
---@type LazySpec
return {
    "nvim-telescope/telescope-symbols.nvim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = libfzf.is_buildable(),
        build = libfzf.build(),
        config = function(plug, _)
            libfzf.load(plug)
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-telescope/telescope-fzf-native.nvim" },
        cmd = "Telescope",
        ---@param o table
        opts = function(_, o)
            local actions = require("telescope.actions")
            local config = require("telescope.config")

            local custom_rg = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
            local vimgrep_arg = { unpack(config.values.vimgrep_arguments) }
            for i, rg_arg in ipairs(custom_rg) do
                if i > 2 then
                    table.insert(vimgrep_arg, rg_arg)
                end
            end
            o = o or {}
            o.defaults = {
                mappings = {
                    i = {
                        ["<Esc>"] = actions.close,
                    },
                },
                vimgrep_arguments = vimgrep_arg,
            }
            o.pickers = {
                find_files = {
                    find_command = custom_rg,
                },
            }
            o.extensions = {
                file_browser = {
                    hijack_netrw = true,
                    hidden = true,
                    no_ignore = true,
                },
            }
        end,
        keys = {
            { "<leader>ff", ":Telescope find_files<cr>", mode = "n", silent = true, desc = "Find files" },
            { "<leader>fg", ":Telescope live_grep<cr>", mode = "n", silent = true, desc = "Live grep" },
            { "<leader>fG", ":Telescope git_files<cr>", mode = "n", silent = true, desc = "Git files" },
            { "<leader>fb", ":Telescope buffers<cr>", mode = "n", silent = true, desc = "Buffers" },
            { "<leader>fr", ":Telescope oldfiles<cr>", mode = "n", silent = true, desc = "Recent Files" },
            { "<leader>fh", ":Telescope help_tags<cr>", mode = "n", silent = true, desc = "Find Help" },
        },
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        config = function()
            require("telescope").load_extension("file_browser")
        end,
        keys = {
            {
                "<leader>fB",
                ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
                mode = "n",
                desc = "File browser",
            },
        },
    },
}
