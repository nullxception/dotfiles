local wezterm = require("wezterm")
local config = wezterm.config_builder()
local cherry = require("cherry")

cherry.setup(config, "Cherry Midnight")
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Bold" })
config.font_size = 9
config.window_background_opacity = 0.8
config.adjust_window_size_when_changing_font_size = false
config.show_tab_index_in_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
    left = "20px",
    right = "20px",
    top = "20px",
    bottom = "20px",
}

-- windows specific settings
if wezterm.target_triple == "x86_64-pc-windows-msvc" then
    config.win32_system_backdrop = "Acrylic"
end

return config
