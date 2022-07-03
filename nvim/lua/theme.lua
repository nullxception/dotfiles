local util = require("tokyonight.util")

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_comments = 1
vim.g.tokyonight_transparent = 1
vim.g.tokyonight_colors = {
    comment = '#767f99',
    bg_statusline = '#23232f'
}

vim.cmd 'colorscheme tokyonight'

util.highlight('LineNr', { fg = '#5d5d78' })
