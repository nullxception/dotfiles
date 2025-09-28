---@type Wezterm
local wezterm = require("wezterm")
local config = wezterm.config_builder()
local cherry = require("cherry")

cherry.setup(config, "Cherry Midnight")
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 9
config.adjust_window_size_when_changing_font_size = false
config.warn_about_missing_glyphs = false
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.initial_cols = 92
config.initial_rows = 32
config.window_padding = {
    left = "20px",
    right = "20px",
    top = "20px",
    bottom = "20px",
}
config.window_background_opacity = 0.9

-- windows specific settings
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    if #wezterm.glob("C:/Prog*/PowerSh*/*/pwsh.exe") > 0 then
        config.default_prog = { "pwsh.exe", "-NoLogo" }
    else
        config.default_prog = { "powershell.exe", "-NoLogo" }
    end
    config.keys = {
        -- workaround for <C-space> not working on nvim
        {
            key = " ",
            mods = "CTRL",
            action = wezterm.action.SendKey({ key = " ", mods = "CTRL" }),
        },
    }
end

return config
