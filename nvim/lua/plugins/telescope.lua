vim.pack.add({
    gh("nvim-telescope/telescope-symbols.nvim"),
    gh("nvim-telescope/telescope-fzf-native.nvim"),
    gh("nvim-telescope/telescope-file-browser.nvim"),
    gh("nvim-telescope/telescope.nvim"),
}, { confirm = false })

local telescope = require("telescope")
local actions = require("telescope.actions")
local config = require("telescope.config")

local opts = {
    defaults = {
        mappings = {
            i = {
                ["<Esc>"] = actions.close,
            },
        },
    },
    extensions = {
        file_browser = {
            hijack_netrw = true,
            hidden = true,
            no_ignore = true,
        },
    },
}

if vim.fn.executable("rg") == 1 then
    local rg = { "rg", "--files", "--hidden", "--no-ignore", "--glob", "!**/.git/*" }
    local vg_arg = { unpack(config.values.vimgrep_arguments) }
    for i, rg_arg in ipairs(rg) do
        if i > 2 then
            table.insert(vg_arg, rg_arg)
        end
    end
    local rg_scope = {
        defaults = { vimgrep_arguments = vg_arg },
        pickers = { find_files = { find_command = rg } },
    }
    opts = vim.tbl_deep_extend("force", opts, rg_scope)
end

telescope.setup(opts)
telescope.load_extension("file_browser")

local libfzf = require("libfzf")
libfzf.load()

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(packOpts)
        if packOpts.data.spec.name == "telescope-fzf-native.nvim" and packOpts.data.kind == "update" then
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
