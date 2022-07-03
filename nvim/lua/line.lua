local cnight = require('lualine.themes.tokyonight')

cnight.normal.b.bg = '#43434f'
cnight.insert.b.bg = '#43434f'
cnight.command.b.bg = '#43434f'
cnight.visual.b.bg = '#43434f'
cnight.replace.b.bg = '#43434f'

require('lualine').setup{
    options = {
        theme = cnight,
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''}
    }
}
