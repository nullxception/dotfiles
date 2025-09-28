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
                sidebars = "transparent",
                floats = "transparent",
            },
            transparent = true,
            terminal_colors = true,
            ---@param c ColorScheme
            on_colors = function(c)
                c.comment = "#767f99"
                c.bg_statusline = "#23232F"
            end,
            ---@param hl tokyonight.Highlights
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
}
