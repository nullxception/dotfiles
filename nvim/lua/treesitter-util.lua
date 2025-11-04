local M = {}

---Ensure tree-sitter CLI is available, installing via mason if needed
---@param cb function Callback to run when tree-sitter CLI is available
function M.ensure_tscli(cb)
    if vim.fn.executable("tree-sitter") == 1 then
        cb()
        return
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

---Check if system has low memory (< 2GB)
---@return boolean
function M.low_mem()
    local mem = vim.uv.get_free_memory() / (1024 ^ 3)
    return mem < 2
end

---Install missing tree-sitter parsers
---@param languages string[] List of language parsers to install
function M.install_missing(languages)
    if vim.fn.executable("tree-sitter") ~= 1 then
        vim.notify("tree-sitter-cli is not installed, cannot install tree-sitter parsers", vim.log.levels.WARN)
        return
    end

    if vim.uv.os_uname().sysname == "Windows_NT" then
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
    local installed_parsers = config.get_installed("parsers")
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

return M