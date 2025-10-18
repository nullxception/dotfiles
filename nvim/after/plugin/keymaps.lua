vim.api.nvim_create_autocmd("LspAttach", {
    desc = "LSP actions",
    callback = function(ev)
        local vk = vim.keymap
        local b = vim.lsp.buf

        vk.set("n", "K", b.hover, { buffer = ev.buf, desc = "Hover" })
        vk.set("n", "gd", b.definition, { buffer = ev.buf, desc = "Go to definition" })
        vk.set("n", "gD", b.declaration, { buffer = ev.buf, desc = "Go to declaration" })
        vk.set("n", "gi", b.implementation, { buffer = ev.buf, desc = "Go to implementation" })
        vk.set("n", "go", b.type_definition, { buffer = ev.buf, desc = "Go to type definition" })
        vk.set("n", "gr", b.references, { buffer = ev.buf, desc = "References", nowait = true })
        vk.set("n", "gs", b.signature_help, { buffer = ev.buf, desc = "Signatures" })
        vk.set({ "n", "i" }, "<F2>", b.rename, { buffer = ev.buf, desc = "Rename" })
        vk.set({ "n", "i" }, "<F4>", b.code_action, { buffer = ev.buf, desc = "Code action" })
    end,
})

local telescope = require("telescope")
local builtin = require("telescope.builtin")
local term = require("nxc.term")
local wk = require("which-key")
wk.add({
    { "<Esc><Esc>", "<Esc>:nohlsearch<CR>", mode = "n", silent = true, hidden = true },
    { "<A-`>", term.toggle, mode = { "n", "t", "i" }, silent = true, desc = "Open terminal" },
    { "<leader>f", group = "Files", mode = "n" },
    { "<leader>ff", builtin.find_files, mode = "n", desc = "Find by name" },
    { "<leader>fg", builtin.live_grep, mode = "n", desc = "Grep string" },
    { "<leader>fG", builtin.git_files, mode = "n", desc = "Git files" },
    { "<leader>fb", telescope.extensions.file_browser.file_browser, mode = "n", desc = "Browse file" },
    { "<leader>fo", builtin.oldfiles, mode = "n", desc = "Old files" },
    { "<leader>h", builtin.help_tags, mode = "n", desc = "Help" },
    { "<leader>b", builtin.buffers, mode = "n", desc = "Buffers" },
})
