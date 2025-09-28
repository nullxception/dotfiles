---@module "lazy"
---@type LazySpec
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
        config = function()
            require("nvim-treesitter.configs").setup({
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
                modules = {},
                sync_install = false,
                ignore_install = {},
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                },
            })
        end,
    },
}
