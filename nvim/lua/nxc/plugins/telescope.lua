local libfzf = require("nxc.libfzf")

---@module "lazy"
---@type LazySpec
return {
    "nvim-telescope/telescope-symbols.nvim",
    {
        "nvim-telescope/telescope.nvim",
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
    },
    {
        "nvim-telescope/telescope-file-browser.nvim",
        init = function()
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = libfzf.is_buildable(),
        build = libfzf.build(),
        init = libfzf.load,
    },
}
