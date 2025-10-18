local utils = require("nxc.utils")

---@module "lazy"
---@type LazySpec
return {
    {
        "folke/tokyonight.nvim",
        priority = 1000,
        ---@module "tokyonight"
        ---@type tokyonight.Config
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
        ---@module "notify"
        ---@type notify.Config
        opts = {
            merge_duplicates = true,
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
    "b0o/schemastore.nvim",
    "neovim/nvim-lspconfig",
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
        ---@type MasonLspconfigSettings
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
    },
    {
        "zapling/mason-conform.nvim",
        opts = {},
    },
    {
        "DrKJeff16/wezterm-types",
        lazy = true,
        version = false,
    },
    {
        "folke/lazydev.nvim",
        ft = "lua",
        ---@module "lazydev"
        ---@type lazydev.Config
        opts = {
            library = {
                { path = "${3rd}/luv/library", words = { "vim%.uv" } },
                { path = "wezterm-types", mods = { "wezterm" } },
            },
        },
    },
    {
        "saghen/blink.cmp",
        version = "1.*",
        event = { "InsertEnter", "CmdlineEnter" },
        ---@module "blink-cmp"
        ---@type blink.cmp.Config
        opts = {
            sources = {
                default = { "lazydev", "lsp", "path", "snippets", "buffer" },
                providers = {
                    lazydev = {
                        name = "LazyDev",
                        module = "lazydev.integrations.blink",
                        score_offset = 100,
                    },
                },
            },
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
            signature = {
                enabled = true,
                window = {
                    show_documentation = false,
                },
            },
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
        ---@module "neogit"
        ---@type NeogitConfig
        opts = {
            telescope_sorter = function()
                require("telescope").extensions.fzf.native_fzf_sorter()
            end,
        },
        keys = {
            { "<leader>gg", function() require("neogit").open() end, desc = "NeoGit" },
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
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        ---@module "which-key"
        ---@type wk.Opts
        opts = {
            win = {
                border = "rounded",
            },
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show({ global = false })
                end,
                desc = "Buffer Local Keymaps",
            },
        },
    },
}
