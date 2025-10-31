vim.pack.add({
    { src = gh("saghen/blink.cmp"), version = vim.version.range("1.*") },
}, { confirm = false })

require("blink.cmp").setup({
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
    signature = {
        enabled = true,
    },
    cmdline = {
        completion = {
            menu = {
                auto_show = true,
            },
        },
    },
    completion = {
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 150,
        },
    },
})
