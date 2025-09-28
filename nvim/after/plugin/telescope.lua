local success, telescope = pcall(require, "telescope")
if not success then
    return
end

local builtin = require("telescope.builtin")
local actions = require("telescope.actions")
local config = require("telescope.config")

local custom_rg = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
local vimgrep_arg = { unpack(config.values.vimgrep_arguments) }
for i, rg_arg in ipairs(custom_rg) do
    if i > 2 then
        table.insert(vimgrep_arg, rg_arg)
    end
end

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
            },
        },
        vimgrep_arguments = vimgrep_arg,
    },
    pickers = {
        find_files = {
            find_command = custom_rg,
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            hidden = true,
            no_ignore = true,
        },
    },
})

if require("nxc.utils").libfzf_buildcmd() ~= nil then
    telescope.load_extension("fzf")
end
telescope.load_extension("file_browser")

vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>lg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", telescope.extensions.file_browser.file_browser, {})
vim.keymap.set("n", "<leader>lb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fg", builtin.git_files, {})
vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
