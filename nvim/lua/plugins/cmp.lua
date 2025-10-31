vim.pack.add({
    gh("DrKJeff16/wezterm-types"),
    gh("folke/lazydev.nvim"),
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
}, { confirm = false })

require("lazydev").setup({
    library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "wezterm-types", mods = { "wezterm" } },
    },
})

require("blink.cmp").setup({
    sources = {
        default = {
            "lazydev",
            "lsp",
            "path",
            "snippets",
            "buffer",
        },
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
})
