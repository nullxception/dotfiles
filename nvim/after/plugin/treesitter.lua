local success, _ = pcall(require, "nvim-treesitter.configs")
if not success then
    return
end

require('nvim-treesitter.configs').setup({
    ensure_installed = {
        "bash",
        "c",
        "cpp",
        "css",
        "dart",
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
    auto_install = true,
    highlight = {
        enable = true,
    },
    indent = {
        enable = true,
    },
})
