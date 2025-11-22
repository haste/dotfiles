local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font = wezterm.font("SauceCodePro Nerd Font", { weight = "Regular", italic = false })
config.font_size = 10
config.line_height = 1.1

config.color_scheme = "Dracula (Official)"

config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "NONE"

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

config.selection_word_boundary = " \t\n{}[]()\"'`:"

config.keys = {
  { key = "Enter", mods = "SHIFT", action = wezterm.action({ SendString = "\x1b\r" }) },
}

return config
