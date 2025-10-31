vim.pack.add({
    gh("folke/tokyonight.nvim"),
    gh("nvim-lualine/lualine.nvim"),
    gh("nvim-mini/mini.icons"),
    gh("nvim-mini/mini.indentscope"),
    gh("sphamba/smear-cursor.nvim"),
}, { confirm = false })

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
        c.bg_statusline = "#23232F"
    end,
    ---@param hl tokyonight.Highlights
    on_highlights = function(hl, _)
        hl.CursorLineNr = { fg = "#83838f" }
        hl.LineNr = { fg = "#5d5d78" }
        hl.FloatBorder = { fg = hl.LineNr.fg }
    end,
})
vim.cmd.colorscheme("tokyonight")

local lualine = require("lualine")
lualine.setup({
    options = {
        theme = "tokyonight",
        globalstatus = true,
    },
})
vim.g.lualine_laststatus = vim.o.laststatus

local indentscope = require("mini.indentscope")
indentscope.setup({
    symbol = "│",
    options = { try_as_border = true },
})
local augroup = vim.api.nvim_create_augroup("UserMiniIndentAuto", { clear = true })
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
    end,
})

local icons = require("mini.icons")
icons.setup({})
icons.mock_nvim_web_devicons()

require("smear_cursor").setup({
    legacy_computing_symbols_support = true,
})
