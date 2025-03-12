local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'Monaco'
config.window_decorations = 'RESIZE'

return config