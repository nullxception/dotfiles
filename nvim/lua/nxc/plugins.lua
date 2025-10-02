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
    { "nvim-tree/nvim-web-devicons", lazy = true },
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
        opts = function(_, o)
            local servers = {
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
            }

            if vim.fn.has("win32") ~= 1 then
                -- kotlin_lsp is not supported on windows yet
                table.insert(servers, "kotlin_lsp")
            end

            o.ensure_installed = servers
        end,
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
        "L3MON4D3/LuaSnip",
        init = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lua",
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, o)
            local cmp = require("cmp")
            o.snippet = {
                expand = function(args)
                    vim.snippet.expand(args.body)
                end,
            }
            o.window = {
                completion = cmp.config.window.bordered(),
                documentation = cmp.config.window.bordered(),
            }
            o.sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer", keyword_length = 3 },
                { name = "luasnip", keyword_length = 2 },
                { name = "path" },
                { name = "nvim_lua" },
            })
            o.mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = false }),
            })
        end,
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
            kind = "floating",
            commit_editor = { kind = "floating" },
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
        opts = {},
    },
}
