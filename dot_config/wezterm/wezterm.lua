-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'tokyonight_night'

config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.9

config.font_size = 13

-- and finally, return the configuration to wezterm
return config
