vim.pack.add({
    gh("folke/tokyonight.nvim"),
    gh("nvim-mini/mini.icons"),
    gh("nvim-mini/mini.indentscope"),
    gh("sphamba/smear-cursor.nvim"),
    gh("folke/snacks.nvim"),
    gh("sschleemilch/slimline.nvim"),
    gh("declancm/cinnamon.nvim"),
    gh("j-hui/fidget.nvim"),
    gh("ingur/floatty.nvim"),
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

require("cinnamon").setup({
    -- Enable all provided keymaps
    keymaps = {
        basic = true,
        extra = true,
    },
    -- Only scroll the window
    options = { mode = "window" },
})
local floatty = require("floatty").setup({
    cmd = function()
        if vim.uv.os_uname().sysname == "Windows" then
            if vim.fn.executable("pwsh") == 1 then
                return "pwsh -NoLogo"
            elseif vim.fn.executable("powershell") == 1 then
                return "powershell -NoLogo"
            end
        end
        return vim.o.shell
    end,
    window = {
        row = vim.o.lines - 11,
        width = 1.0,
        height = 8,
    },
})

vim.keymap.set({ "n", "t", "i" }, "<A-`>", floatty.toggle, { desc = "Toggle Terminal" })

local snacks = require("snacks")
snacks.setup({
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
                    action = floatty.toggle,
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
})

local indentscope = require("mini.indentscope")
indentscope.setup({
    symbol = "│",
    options = { try_as_border = true },
})
local augroup = vim.api.nvim_create_augroup("UserUIAuto", { clear = true })
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

require("fidget").setup({
    notification = { override_vim_notify = true },
})
