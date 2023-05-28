require("tokyonight").setup({
    style = "night",
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
    },
    transparent = true,
    terminal_colors = true,
    on_colors = function(c)
        c.comment = "#767f99"
        c.bg_statusline = "#23232F"
    end,
    on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = "#83838f" }
        hl.LineNr = { fg = "#5d5d78" }
        hl.FloatBorder = { fg = hl.LineNr.fg }
    end,
})
vim.cmd.colorscheme("tokyonight")
