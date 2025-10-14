local utils = require("nxc.utils")

return { ---@type LazySpec
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        opts = {
            style = "night",
            styles = {
                comments = { italic = true },
                keywords = { italic = true },
            },
            transparent = true,
            terminal_colors = true,
            on_colors = function(c)
                c.comment = "#767f99"
                c.bg_statusline = "#23232F"
            end,
            on_highlights = function(hl, _)
                hl.CursorLineNr = { fg = "#83838f" }
                hl.LineNr = { fg = "#5d5d78" }
                hl.FloatBorder = { fg = hl.LineNr.fg }
            end,
        },
        init = function()
            vim.cmd.colorscheme("tokyonight")
        end,
    },
    {
        "rcarriga/nvim-notify",
        priority = 999,
        opts = {
            render = "wrapped-compact",
            stages = "static",
            timeout = 2500,
            top_down = false,
        },
        init = function()
            vim.notify = require("notify")
        end,
    },
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
    "nvim-lua/popup.nvim",
    "stevearc/dressing.nvim",
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "tokyonight",
                globalstatus = true,
            },
        },
    },
    {
        "glepnir/dashboard-nvim",
        event = "VimEnter",
        opts = require("nxc.dashboard"),
    },
    { "nvim-lua/plenary.nvim", lazy = true },
    {
        "nvim-mini/mini.icons",
        version = false,
        init = function()
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        branch = "master",
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason.nvim",
        opts = {
            ui = { border = "single" },
        },
    },
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "bashls",
                "cssls",
                "docker_compose_language_service",
                "html",
                "jsonls",
                "lua_ls",
                "postgres_lsp",
                "powershell_es",
                "ts_ls",
                "vimls",
                "yamlls",
            },
        },
    },
    {
        "stevearc/conform.nvim",
        opts = function(_, o)
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
    },
    {
        "zapling/mason-conform.nvim",
        opts = {},
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        opts = {
            keymap = {
                preset = "super-tab",
                ["<C-u>"] = { "scroll_signature_up", "fallback" },
                ["<C-d>"] = { "scroll_signature_down", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                    auto_show_delay_ms = 150,
                },
                ghost_text = { enabled = true },
                menu = {
                    draw = {
                        treesitter = { "lsp" },
                        components = {
                            kind_icon = {
                                text = function(ctx)
                                    local kind_icon, _, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return kind_icon
                                end,
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                            kind = {
                                highlight = function(ctx)
                                    local _, hl, _ = require("mini.icons").get("lsp", ctx.kind)
                                    return hl
                                end,
                            },
                        },
                    },
                },
            },
            signature = { enabled = true },
            cmdline = {
                keymap = { preset = "inherit" },
                completion = { menu = { auto_show = true } },
            },
        },
    },
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
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = {},
    },
    "tpope/vim-fugitive",
    "sindrets/diffview.nvim",
    {
        "NeogitOrg/neogit",
        opts = {
            telescope_sorter = function()
                return require("telescope").extensions.fzf.native_fzf_sorter()
            end,
        },
        keys = {
            {
                "<leader>ng",
                function()
                    require("neogit").open()
                end,
                desc = "Neogit",
            },
        },
    },
    "lambdalisue/suda.vim",
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        cond = utils.libfzf_buildcmd() ~= nil,
        build = utils.libfzf_buildcmd(),
    },
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-symbols.nvim",
    "nvim-telescope/telescope.nvim",
    {
        "wakatime/vim-wakatime",
        lazy = false,
        opts = {
            plugin_name = "neovim-wakatime", -- fix editor = 'unknown' issues on wakapi
            heartbeat_frequency = 1,
        },
    },
    {
        "nvim-mini/mini.indentscope",
        version = false,
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "dashboard",
                    "fzf",
                    "help",
                    "lazy",
                    "mason",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
        end,
    },
}
