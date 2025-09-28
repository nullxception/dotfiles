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

            if vim.fn.executable("npm") == 1 then
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
            end
        end,
        init = function()
            local function cleanup_trailing_spaces()
                if vim.bo.filetype == "markdown" then
                    return
                end
                vim.cmd([[%s/\s\+$//e]])
            end

            local augroup = vim.api.nvim_create_augroup("UserConformAuto", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
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
        dependencies = { "stevearc/conform.nvim" },
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        opts = {},
    },
}
