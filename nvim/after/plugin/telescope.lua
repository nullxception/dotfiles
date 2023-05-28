local actions = require('telescope.actions')
local telescope = require('telescope')

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ['<Esc>'] = actions.close
            },
        },
    },
    pickers = {
        find_files = {
            hidden = true
        }
    },
})

telescope.load_extension('fzf')
telescope.load_extension("file_browser")
