local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system{
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    vim.cmd 'packadd packer.nvim'
end

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

require('options')
require('keymaps')
require('cmds')

return packer.startup{
    function(use)
        use { 'wbthomason/packer.nvim' }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use {
            'nvim-telescope/telescope.nvim',
            requires = {
                'nvim-lua/popup.nvim',
                'nvim-lua/plenary.nvim',
                'nvim-telescope/telescope-fzf-native.nvim',
                'nvim-telescope/telescope-symbols.nvim',
            },
            config = function()
                require('scope')
            end,
        }
        use { 'mg979/vim-visual-multi', branch = 'master' }
        use { 'lambdalisue/suda.vim' }
        use { 'tpope/vim-fugitive' }
        use {
            'preservim/nerdtree',
            config = function()
                require('ntree')
            end
        }
        use {
            'folke/tokyonight.nvim',
            config = function()
                require('theme')
            end,
        }
        use {
            'itchyny/lightline.vim',
            config = function()
                require('line')
            end,
        }

        if packer_bootstrap then
            packer.sync()
        end
    end,
    config = {
        git = { clone_timeout = 6000 },
        display = {
            open_fn = function()
              return require('packer.util').float{ border = 'single' }
            end
        }
    },
}
