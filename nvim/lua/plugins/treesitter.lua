local ts_util = require("treesitter-util")

if ts_util.low_mem() then
    return
end

vim.pack.add({
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
    gh("nvim-treesitter/nvim-treesitter-context"),
    { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
}, { confirm = false })

local ensure_installed = {
    "bash",
    "c",
    "cpp",
    "css",
    "dart",
    "diff",
    "git_rebase",
    "gitcommit",
    "gitignore",
    "go",
    "html",
    "ini",
    "java",
    "javascript",
    "json",
    "kotlin",
    "lua",
    "markdown",
    "python",
    "rasi",
    "scss",
    "toml",
    "tsx",
    "typescript",
    "yaml",
    "vimdoc",
}

vim.api.nvim_create_autocmd("PackChanged", {
    callback = function(opts)
        if opts.data.spec.name == "nvim-treesitter" and opts.data.kind == "update" then
            vim.cmd("TSUpdate")
        end
    end,
})

ts_util.ensure_tscli(function()
    ts_util.install_missing(ensure_installed)
end)

local ts = require("nvim-treesitter.config")
local installed_parsers = ts.get_installed("parsers")

local augroup = vim.api.nvim_create_augroup("UserTSAuto", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
    group = augroup,
    callback = function()
        local ft = vim.bo.filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not vim.tbl_contains(ts.get_available(), lang) then
            return
        end
        if not vim.tbl_contains(installed_parsers, lang) then
            ts_util.install_missing({ lang })
        end
    end,
})

vim.api.nvim_create_autocmd("FileType", {
    group = augroup,
    pattern = "*",
    callback = function()
        local success, _ = pcall(vim.treesitter.start)
        if not success then
            return
        end

        vim.bo.indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
    end,
})

require("nvim-treesitter-textobjects").setup({
    move = { set_jumps = true },
})

local o_select = require("nvim-treesitter-textobjects.select")

local function map_select_object(key, object, source)
    local desc = object:gsub("@", ""):gsub("%.", " ")

    vim.keymap.set({ "x", "o" }, key, function()
        o_select.select_textobject(object, source or "textobjects")
    end, { desc = desc })
end

map_select_object("af", "@function.outer")
map_select_object("if", "@function.inner")
map_select_object("ac", "@class.outer")
map_select_object("ic", "@class.inner")
map_select_object("al", "@local.scope", "locals")
