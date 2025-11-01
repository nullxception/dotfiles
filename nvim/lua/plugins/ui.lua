vim.pack.add({
    gh("folke/tokyonight.nvim"),
    gh("nvim-mini/mini.icons"),
    gh("nvim-mini/mini.indentscope"),
    gh("sphamba/smear-cursor.nvim"),
    gh("folke/snacks.nvim"),
    gh("sschleemilch/slimline.nvim"),
}, { confirm = false })

local icons = require("mini.icons")
icons.setup({})
icons.mock_nvim_web_devicons()

require("tokyonight").setup({
    style = "night",
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        sidebars = "transparent",
        floats = "transparent",
    },
    transparent = true,
    terminal_colors = true,
    ---@param c ColorScheme
    on_colors = function(c)
        c.comment = "#767f99"
        c.bg_statusline = nil
    end,
    ---@param hl tokyonight.Highlights
    on_highlights = function(hl, _)
        hl.CursorLineNr = { fg = "#83838f" }
        hl.LineNr = { fg = "#5d5d78" }
        hl.FloatBorder = { fg = hl.LineNr.fg }
    end,
})
vim.cmd.colorscheme("tokyonight")

require("slimline").setup({
    style = "fg",
    spaces = {
        components = "",
        left = "",
        right = "",
    },
})

local snacks = require("snacks")
snacks.setup({
    picker = {},
    notifier = {
        top_down = false,
        margin = { bottom = 2 },
    },
    terminal = {
        win = { height = 0.25 },
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
        vim.o.laststatus = 3 -- enable statusline on dashboard
    end,
})

require("smear_cursor").setup({
    legacy_computing_symbols_support = true,
})
