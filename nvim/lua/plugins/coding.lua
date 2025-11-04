vim.pack.add({
    gh("b0o/schemastore.nvim"),
    gh("neovim/nvim-lspconfig"),
    gh("mason-org/mason-lspconfig.nvim"),
    gh("DrKJeff16/wezterm-types"),
    gh("folke/lazydev.nvim"),
    gh("stevearc/conform.nvim"),
    gh("WhoIsSethDaniel/mason-tool-installer.nvim"),
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
}, { confirm = false })

if vim.fn.executable("kotlin-lsp") ~= nil then
    vim.lsp.enable("kotlin_lsp")
end

local ensure_installed = {
    "postgres_lsp",
}
if vim.fn.executable("npm") == 1 then
    vim.list_extend(ensure_installed, {
        "bashls",
        "cssls",
        "docker_compose_language_service",
        "html",
        "jsonls",
        "lua_ls",
        "ts_ls",
        "vimls",
        "yamlls",
    })
end

if vim.fn.executable("go") == 1 then
    table.insert(ensure_installed, "hyprls")
end

if vim.fn.executable("pwsh") == 1 then
    table.insert(ensure_installed, "powershell_es")
end

require("mason-lspconfig").setup({ ensure_installed = ensure_installed })

local augroup = vim.api.nvim_create_augroup("UserCodingAuto", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
    group = augroup,
    desc = "LSP actions",
    callback = function(ev)
        local vk = vim.keymap
        local b = vim.lsp.buf

        vk.set("n", "K", b.hover, { buffer = ev.buf, desc = "Hover" })
        vk.set("n", "gd", b.definition, { buffer = ev.buf, desc = "Go to definition" })
        vk.set("n", "gD", b.declaration, { buffer = ev.buf, desc = "Go to declaration" })
        vk.set("n", "gi", b.implementation, { buffer = ev.buf, desc = "Go to implementation" })
        vk.set("n", "go", b.type_definition, { buffer = ev.buf, desc = "Go to type definition" })
        vk.set("n", "gr", b.references, { buffer = ev.buf, desc = "References", nowait = true })
        vk.set("n", "gs", b.signature_help, { buffer = ev.buf, desc = "Signatures" })
        vk.set({ "n", "i" }, "<F2>", b.rename, { buffer = ev.buf, desc = "Rename" })
        vk.set({ "n", "i" }, "<F4>", b.code_action, { buffer = ev.buf, desc = "Code action" })
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    once = true,
    group = augroup,
    pattern = "*.lua",
    callback = function()
        require("lazydev").setup({
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "wezterm-types", mods = { "wezterm" } },
            },
        })
    end,
})

local formatters = {
    sh = { "shfmt" },
    lua = { "stylua" },
    rust = { "rustfmt" },
}
local prettierft = {
    "css",
    "less",
    "scss",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "html",
    "json",
    "yaml",
    "markdown",
}
for _, ft in ipairs(prettierft) do
    formatters[ft] = { "prettierd" }
end

local tools = {}
for _, fmts in pairs(formatters) do
    for _, fmt in ipairs(fmts) do
        if fmt == "rustfmt" then
            -- rustfmt should not be installed from mason
            goto skip
        end
        if not vim.tbl_contains(tools, fmt) then
            table.insert(tools, fmt)
        end
        ::skip::
    end
end

require("mason-tool-installer").setup({ ensure_installed = tools })

local conform = require("conform")
conform.setup({
    default_format_opts = {
        lsp_format = "fallback",
    },
    formatters_by_ft = formatters,
})

local function cleanup_trailing_spaces()
    if vim.bo.filetype == "markdown" then
        return
    end
    vim.cmd([[%s/\s\+$//e]])
end

vim.api.nvim_create_autocmd("BufWritePre", {
    group = augroup,
    pattern = "*",
    callback = function(args)
        cleanup_trailing_spaces()
        conform.format({ bufnr = args.buf })
    end,
})

require("blink.cmp").setup({
    sources = {
        default = { "lazydev", "lsp", "path", "snippets", "buffer" },
        providers = {
            lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
        },
    },
    signature = { enabled = true },
    cmdline = {
        completion = { menu = { auto_show = true } },
    },
    completion = {
        documentation = { auto_show = true, auto_show_delay_ms = 150 },
    },
})

local ts_util = require("treesitter-util")
if ts_util.low_mem() then
    goto after_treesitter
end

vim.pack.add({
    { src = gh("nvim-treesitter/nvim-treesitter"), version = "main" },
    gh("nvim-treesitter/nvim-treesitter-context"),
    { src = gh("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },
}, { confirm = false })

local ts_ft = {
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
    ts_util.install_missing(ts_ft)
end)

local ts = require("nvim-treesitter.config")
local installed_parsers = ts.get_installed("parsers")

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

require("nvim-treesitter-textobjects").setup({ move = { set_jumps = true } })
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

::after_treesitter::
