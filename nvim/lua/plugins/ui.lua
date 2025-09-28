---@module "lazy"
---@type LazySpec
return {
    "nvim-lua/popup.nvim",
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@module "snacks"
        ---@type snacks.Config
        opts = {
            picker = {},
            notifier = {
                top_down = false,
                margin = { bottom = 2 },
            },
            terminal = {
                win = { height = 0.25 },
            },
            dashboard = {
                enabled = true,
                preset = {
                    pick = "telescope.nvim",
                    header = require("core.herta").normal,
                    keys = {
                        { icon = " ", key = "f", desc = "Find File", action = ":Telescope find_files" },
                        { icon = " ", key = "g", desc = "Find Text", action = ":Telescope live_grep" },
                        { icon = " ", key = "r", desc = "Recent Files", action = ":Telescope oldfiles" },
                        {
                            icon = " ",
                            mode = "n",
                            key = "B",
                            desc = "File Browser",
                            action = function()
                                require("telescope").extensions.file_browser.file_browser()
                            end,
                        },
                        { icon = " ", key = "s", desc = "Restore Session", section = "session" },
                        {
                            icon = " ",
                            icon_hl = "Title",
                            desc = "NeoGit",
                            key = "n",
                            keymap = "<leader>ng",
                            action = ":Neogit",
                        },
                        {
                            icon = " ",
                            icon_hl = "Title",
                            desc = "Terminal",
                            key = "`",
                            keymap = "<A-`>",
                            action = ":lua Snacks.terminal()",
                        },
                        {
                            icon = " ",
                            key = "c",
                            desc = "Config",
                            action = function()
                                require("telescope.builtin").find_files({ cwd = vim.fn.stdpath("config") })
                            end,
                        },
                        {
                            icon = "󰒲 ",
                            key = "L",
                            desc = "Lazy",
                            action = ":Lazy",
                            enabled = package.loaded.lazy ~= nil,
                        },
                    },
                },
                sections = {
                    { section = "header" },
                    {
                        pane = 2,
                        { section = "keys", gap = 1, padding = 1 },
                        { section = "startup" },
                    },
                },
            },
            styles = {
                notifier = {
                    backdrop = false,
                },
            },
        },
        init = function()
            local augroup = vim.api.nvim_create_augroup("UserSnacksAuto", { clear = true })
            vim.api.nvim_create_autocmd("LspProgress", {
                group = augroup,
                ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
                callback = function(ev)
                    local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                    vim.notify(vim.lsp.status(), "info", {
                        id = "lsp_progress",
                        title = "LSP Progress",
                        opts = function(notif)
                            notif.icon = ev.data.params.value.kind == "end" and " "
                                or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                        end,
                    })
                end,
            })
        end,
        keys = {
            {
                "<A-`>",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
                mode = { "n", "t", "i" },
            },
        },
    },
    {
        "nvim-mini/mini.icons",
        version = false,
        init = function()
            require("mini.icons").mock_nvim_web_devicons()
        end,
    },
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                theme = "tokyonight",
                globalstatus = true,
            },
        },
        init = function()
            vim.g.lualine_laststatus = vim.o.laststatus
        end,
    },
    {
        "nvim-mini/mini.indentscope",
        event = { "BufReadPost", "BufNewFile", "BufWritePre" },
        version = false,
        opts = {
            symbol = "│",
            options = { try_as_border = true },
        },
        init = function()
            local augroup = vim.api.nvim_create_augroup("UserMiniIndentAuto", { clear = true })
            vim.api.nvim_create_autocmd("FileType", {
                group = augroup,
                pattern = {
                    "snacks_dashboard",
                    "fzf",
                    "help",
                    "lazy",
                    "mason",
                },
                callback = function()
                    vim.b.miniindentscope_disable = true
                end,
            })
            vim.api.nvim_create_autocmd("User", {
                group = augroup,
                pattern = "SnacksDashboardOpened",
                callback = function(data)
                    vim.b[data.buf].miniindentscope_disable = true
                end,
            })
        end,
    },
    {
        "sphamba/smear-cursor.nvim",
        event = "VeryLazy",
        opts = {
            legacy_computing_symbols_support = true,
        },
    },
}
