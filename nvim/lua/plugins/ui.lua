vim.pack.add({
    gh("folke/tokyonight.nvim"),
    gh("nvim-lualine/lualine.nvim"),
    gh("nvim-mini/mini.indentscope"),
    gh("sphamba/smear-cursor.nvim"),
    gh("folke/snacks.nvim"),
    gh("folke/which-key.nvim"),
    gh("declancm/cinnamon.nvim"),
    gh("lewis6991/gitsigns.nvim"),
}, { confirm = false })

require("tokyonight").setup({
    style = "night",
    styles = {
        sidebars = "transparent",
        floats = "transparent",
    },
    transparent = true,
    terminal_colors = true,
    ---@param c ColorScheme
    on_colors = function(c)
        c.bg_statusline = nil
    end,
})
vim.cmd.colorscheme("tokyonight")

require("cinnamon").setup({
    keymaps = {
        basic = true,
        extra = true,
    },
    options = { mode = "window" },
})

local snacks = require("snacks")
local shell = vim.o.shell
if vim.uv.os_uname().sysname == "Windows_NT" then
    if vim.fn.executable("pwsh") == 1 then
        shell = "pwsh -NoLogo"
    elseif vim.fn.executable("powershell") == 1 then
        shell = "powershell -NoLogo"
    end
end
snacks.setup({
    picker = {},
    notifier = {
        top_down = false,
        margin = { bottom = 2 },
        style = "minimal",
    },
    terminal = {
        win = { height = 0.25 },
        shell = shell,
    },
    dashboard = {
        enabled = true,
        preset = {
            pick = "telescope.nvim",
            header = require("herta").normal,
            keys = {
                { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
                { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
                {
                    icon = " ",
                    mode = "n",
                    key = "B",
                    desc = "File Browser",
                    action = function()
                        require("telescope").extensions.file_browser.file_browser()
                    end,
                },
                { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                {
                    icon = " ",
                    icon_hl = "Title",
                    desc = "NeoGit",
                    key = "n",
                    keymap = "<leader>ng",
                    action = ":Neogit",
                },
                {
                    icon = " ",
                    icon_hl = "Title",
                    desc = "Terminal",
                    key = "`",
                    keymap = "<A-`>",
                    action = ":lua Snacks.terminal()",
                },
                {
                    icon = " ",
                    key = "c",
                    desc = "Config",
                    action = function()
                        require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
                    end,
                },
                { icon = " ", key = "q", desc = "Quit", action = ":qa" },
            },
        },
        sections = {
            { section = "header" },
            {
                pane = 2,
                { section = "keys", gap = 1, padding = 1 },
            },
        },
    },
    styles = {
        notifier = {
            backdrop = false,
        },
    },
})

local augroup = vim.api.nvim_create_augroup("UserUIAuto", { clear = true })
vim.api.nvim_create_autocmd("LspProgress", {
    group = augroup,
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(vim.lsp.status(), "info", {
            id = "lsp_progress",
            title = "LSP Progress",
            opts = function(notif)
                notif.icon = ev.data.params.value.kind == "end" and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})

vim.keymap.set({ "n", "t", "i" }, "<A-`>", function()
    Snacks.terminal()
end, { desc = "Toggle Terminal" })

local lualine = require("lualine")
lualine.setup({
    options = {
        theme = "tokyonight",
        globalstatus = true,
        disabled_filetypes = {
            statusline = {},
            winbar = {},
        },
    },
})

local indentscope = require("mini.indentscope")
indentscope.setup({
    symbol = "│",
    options = { try_as_border = true },
})
vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = {
        "snacks_dashboard",
        "fzf",
        "help",
        "lazy",
        "mason",
    },
    callback = function()
        vim.b.miniindentscope_disable = true
    end,
})
vim.api.nvim_create_autocmd("User", {
    group = augroup,
    pattern = "SnacksDashboardOpened",
    callback = function(data)
        vim.b[data.buf].miniindentscope_disable = true
        vim.o.laststatus = 3
    end,
})

require("smear_cursor").setup({
    legacy_computing_symbols_support = true,
})

local wk = require("which-key")
wk.setup({ win = { border = "rounded" } })

wk.add({
    "<leader>?",
    function()
        require("which-key").show({ global = false })
    end,
    desc = "Buffer Local Keymaps",
})

require("gitsigns").setup({
    current_line_blame = true,
    current_line_blame_opts = {
        delay = 300,
    },
})
