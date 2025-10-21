function ensure_tscli(cb)
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
        vim.schedule(cb)
    end)
end

---@param languages string[]
---@param opts InstallOptions
function install_missing(languages, opts)
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
    local installed = config.get_installed("parsers")
    local missing = vim.tbl_filter(function(parser)
        return not vim.tbl_contains(installed, parser)
    end, languages)

    if #missing > 0 then
        require("nvim-treesitter").install(missing, opts)
    end
end

---@module "lazy"
---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
        },
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
            },
        },
        config = function(_, opts)
            opts = opts or {}
            ensure_tscli(function()
                install_missing(opts.ensure_installed, { summary = true })
            end)

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(cb)
                    -- highlight
                    pcall(vim.treesitter.start, cb.buf)
                    -- indentation
                    vim.bo[cb.buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"
                end,
            })
        end,
    },
}
