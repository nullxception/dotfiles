vim.keymap.set('n', '<Esc><Esc>', '<Esc>:nohlsearch<CR>', { silent = true })
vim.keymap.set('n', '<leader><CR>', ':rightbelow 5sp new<CR>:terminal<CR>', { silent = true })
vim.keymap.set('n', '<leader>e', ':NERDTreeToggle %<CR>', { silent = true })
vim.keymap.set('n', '<Leader><leader>', '<cmd>Telescope find_files<cr>', { silent = true })
