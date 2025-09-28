local function build(opts)
    return {
        foreground = opts.foreground,
        background = opts.background,

        cursor_bg = opts.foreground,
        cursor_fg = opts.background,
        cursor_border = opts.foreground,

        selection_fg = opts.background,
        selection_bg = opts.foreground,

        ansi = {
            opts.surface_darker,
            "#ff568e",
            "#64de83",
            "#efff73",
            "#73a9ff",
            "#946ff7",
            "#62c6da",
            opts.on_surface_darker,
        },
        brights = {
            opts.surface,
            "#ff69a2",
            "#73de8a",
            "#f3ff85",
            "#85b6ff",
            "#a481f7",
            "#71c2d9",
            opts.on_surface_darker,
        },

        tab_bar = {
            background = opts.background,
            active_tab = { bg_color = opts.surface_darker, fg_color = opts.foreground },
            inactive_tab = { bg_color = opts.background, fg_color = opts.on_surface_darker },
        },
    }
end

return {
    setup = function(config, name)
        config.color_schemes = {
            ["Cherry Dark"] = build({
                background = "#1f1f2a",
                foreground = "#bdc3df",
                surface = "#53536b",
                on_surface = "#ebebff",
                surface_darker = "#43435a",
                on_surface_darker = "#dedeff",
            }),
            ["Cherry Midnight"] = build({
                background = "#101017",
                foreground = "#bdc3df",
                surface = "#43435a",
                on_surface = "#ebebff",
                surface_darker = "#33333f",
                on_surface_darker = "#dedeff",
            }),
        }
        config.color_scheme = name
    end,
}
