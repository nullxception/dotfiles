local success, _ = pcall(require, "telescope")
if not success then
    return
end

local telescope = require('telescope')
local builtin = require('telescope.builtin')
local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<Esc>'] = actions.close
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true
        }
    },
})

telescope.load_extension('fzf')
telescope.load_extension("file_browser")

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', telescope.extensions.file_browser.file_browser, {})
vim.keymap.set('n', '<leader>lb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
