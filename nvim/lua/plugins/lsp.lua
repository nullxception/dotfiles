---@module "lazy"
---@type LazySpec
return {
    "b0o/schemastore.nvim",
    {
        "neovim/nvim-lspconfig",
        init = function()
            vim.api.nvim_create_autocmd("LspAttach", {
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

            if vim.fn.executable("kotlin-lsp") ~= nil then
                vim.lsp.enable("kotlin_lsp")
            end

            vim.lsp.config.jsonls = {
                settings = {
                    json = {
                        format = { enable = true },
                        validate = { enable = true },
                        schemas = require("schemastore").json.schemas(),
                    },
                },
            }

            if vim.fn.executable("pwsh") == 1 then
                vim.lsp.config.powershell_es = {
                    filetypes = { "ps1", "psm1", "psd1" },
                    bundle_path = vim.fn.expand("$MASON/packages/powershell-editor-services"),
                    settings = {
                        powershell = {
                            codeFormatting = {
                                Preset = "OTBS",
                            },
                        },
                    },
                    init_options = {
                        enableProfileLoading = false,
                    },
                }
            end
        end,
    },
    {
        "mason-org/mason.nvim",
        ---@module "mason"
        ---@type MasonSettings
        opts = {
            ui = { border = "single" },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        ---@module "mason-lspconfig"
        ---@param o MasonLspconfigSettings
        opts = function(_, o)
            o = o or {}
            o.ensure_installed = {
                "bashls",
                "cssls",
                "docker_compose_language_service",
                "html",
                "jsonls",
                "lua_ls",
                "postgres_lsp",
                "ts_ls",
                "vimls",
                "yamlls",
            }

            if vim.fn.executable("pwsh") == 1 then
                table.insert(o.ensure_installed, "powershell_es")
            end
        end,
    },
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    {
        "akinsho/flutter-tools.nvim",
        opts = {
            widget_guides = {
                enabled = true,
            },
            dev_log = {
                open_cmd = "tabedit",
            },
        },
    },
}
