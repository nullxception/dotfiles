local vk = vim.keymap
vk.set({ "n", "v" }, "<leader>cy", '"+y', { desc = "Yank to system clipboard" })
vk.set({ "n" }, "<leader>cp", '"+p', { desc = "Paste from system clipboard" })
vk.set({ "n" }, "<Esc><Esc>", "<Esc>:nohlsearch<CR>", { silent = true })
