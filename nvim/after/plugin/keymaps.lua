vim.keymap.set('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR>', { silent = true })

local builtin = require('telescope.builtin')
local scopext = require('telescope').extensions

vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>lg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', scopext.file_browser.file_browser, {})
vim.keymap.set('n', '<leader>lb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fg', builtin.git_files, {})
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
