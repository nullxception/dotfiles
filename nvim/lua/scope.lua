local actions = require('telescope.actions')
require('telescope').setup{
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
}

require('telescope').load_extension('fzf')
