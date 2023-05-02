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
        c.bg_statusline = "#33333f"
    end,
    on_highlights = function(hl, c)
        hl.CursorLineNr = { fg = "#83838f" }
        hl.LineNr = { fg = "#5d5d78" }
    end,
})

vim.cmd 'colorscheme tokyonight'
