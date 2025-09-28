---@module "lazy"
---@type LazySpec
return {
    {
        "stevearc/conform.nvim",
        ---@module "conform"
        ---@param o conform.setupOpts
        opts = function(_, o)
            o.default_format_opts = {
                lsp_format = "fallback",
            }
            o.formatters_by_ft = {
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
                o.formatters_by_ft[ft] = { "prettierd" }
            end
        end,
        init = function()
            local function cleanup_trailing_spaces()
                if vim.bo.filetype == "markdown" then
                    return
                end
                vim.cmd([[%s/\s\+$//e]])
            end

            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    cleanup_trailing_spaces()
                    require("conform").format({ bufnr = args.buf })
                end,
            })
        end,
    },
    {
        "zapling/mason-conform.nvim",
        opts = {},
    },
}
