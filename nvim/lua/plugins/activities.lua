vim.pack.add({
    gh("wakatime/vim-wakatime"),
    gh("vyfor/cord.nvim"),
}, { confirm = false, load = true })

local home = vim.env.HOME or os.getenv("HOME")
local cfg = vim.fs.joinpath(home, ".wakatime.cfg")
if vim.uv.fs_stat(cfg) ~= nil then
    require("wakatime").setup({
        plugin_name = "neovim-wakatime", -- fix editor = 'unknown' issues on wakapi
        heartbeat_frequency = 1,
    })
end

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
