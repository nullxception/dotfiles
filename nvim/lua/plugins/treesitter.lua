local function ensure_tscli(cb)
    if vim.fn.executable("tree-sitter") == 1 then
        cb()
    end

    local reg = require("mason-registry")
    reg.refresh()
    if not reg.has_package("tree-sitter-cli") then
        return
    end

    local tscli = reg.get_package("tree-sitter-cli")
    tscli:install(nil, function(success, _)
        if not success then
            return
        end
        vim.schedule_wrap(cb)
    end)
end

local installed_parsers = {}

---@param languages string[]
local function install_missing(languages)
    if vim.fn.executable("tree-sitter") ~= 1 then
        vim.notify("tree-sitter-cli is not installed, cannot install tree-sitter parsers", vim.log.levels.WARN)
        return
    end

    if vim.fn.has("win32") == 1 then
        local has_cc = 0
        if vim.fn.executable("gcc") == 1 then
            has_cc = 1
            vim.env.CC = "gcc"
        elseif vim.fn.executable("cl.exe") == 1 then
            has_cc = 1
        end

        if has_cc == 0 then
            vim.notify("no compatible CC installed for tree-sitter", vim.log.levels.ERROR)
            return
        end
    end

    local config = require("nvim-treesitter.config")
    installed_parsers = config.get_installed("parsers")
    local missing = vim.tbl_filter(function(parser)
        return not vim.tbl_contains(installed_parsers, parser)
    end, languages)

    if #missing == 0 then
        return
    end

    require("nvim-treesitter").install(missing, { summary = true }):await(function()
        installed_parsers = config.get_installed("parsers")
        vim.defer_fn(function()
            vim.cmd([[echon '']]) -- clear message
        end, 2000)
    end)
end

local function low_mem()
    local mem = vim.uv.get_free_memory() / (1024 ^ 3)
    return mem < 2
end

---@module "lazy"
---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "mason-org/mason.nvim" },
        cond = not low_mem(),
        lazy = false,
        build = ":TSUpdate",
        branch = "main",
        opts = {
            ensure_installed = {
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
            },
        },
        config = function(_, opts)
            opts = opts or {}
            ensure_tscli(function()
                install_missing(opts.ensure_installed)
            end)

            local ts = require("nvim-treesitter.config")
            installed_parsers = ts.get_installed("parsers")

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
                        install_missing({ lang })
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
        end,
    },
}
