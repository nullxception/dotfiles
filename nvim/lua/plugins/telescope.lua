vim.pack.add({
    gh("nvim-lua/plenary.nvim"),
    gh("nvim-telescope/telescope-symbols.nvim"),
    gh("nvim-telescope/telescope-fzf-native.nvim"),
    gh("nvim-telescope/telescope-file-browser.nvim"),
    gh("nvim-telescope/telescope.nvim"),
}, { confirm = false })

local actions = require("telescope.actions")
local config = require("telescope.config")

local custom_rg = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
local vimgrep_arg = { unpack(config.values.vimgrep_arguments) }
for i, rg_arg in ipairs(custom_rg) do
    if i > 2 then
        table.insert(vimgrep_arg, rg_arg)
    end
end
local o = {}
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

require("telescope").setup(o)
require("telescope").load_extension("file_browser")
local libfzf = require("libfzf")
libfzf.load()

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(opts)
        if opts.data.spec.name == "telescope-fzf-native.nvim" and opts.data.kind == "update" then
            libfzf.build()
        end
    end,
})

local vk = vim.keymap
vk.set("n", "<leader>ff", ":Telescope find_files<cr>", { silent = true, desc = "Find files" })
vk.set("n", "<leader>fg", ":Telescope live_grep<cr>", { silent = true, desc = "Live grep" })
vk.set("n", "<leader>fG", ":Telescope git_files<cr>", { silent = true, desc = "Git files" })
vk.set("n", "<leader>fb", ":Telescope buffers<cr>", { silent = true, desc = "Buffers" })
vk.set("n", "<leader>fr", ":Telescope oldfiles<cr>", { silent = true, desc = "Recent Files" })
vk.set("n", "<leader>fh", ":Telescope help_tags<cr>", { silent = true, desc = "Find Help" })
vk.set(
    "n",
    "<leader>fB",
    ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
    { silent = true, desc = "File browser" }
)
