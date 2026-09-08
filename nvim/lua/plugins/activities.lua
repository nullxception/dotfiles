local home = vim.env.HOME or os.getenv("HOME")
local disabled = vim.fs.joinpath(home, ".wakatime", ".disabled")
if vim.uv.fs_stat(disabled) == nil then
    vim.pack.add({ gh("wakatime/vim-wakatime") }, { confirm = false, load = true })
    require("wakatime").setup({
        plugin_name = "neovim-wakatime", -- fix editor = 'unknown' issues on wakapi
        heartbeat_frequency = 1,
    })
end

vim.pack.add({ gh("vyfor/cord.nvim") }, { confirm = false, load = true })
local augroup = vim.api.nvim_create_augroup("UserActivitiesAuto", { clear = true })
vim.api.nvim_create_autocmd("PackChanged", {
    group = augroup,
    callback = function(opts)
        if opts.data.spec.name == "cord.nvim" and opts.data.kind == "update" then
            vim.cmd("Cord update")
        end
    end,
})
require("cord").setup({
    text = {
        workspace = "In /Library/****",
    },
})
