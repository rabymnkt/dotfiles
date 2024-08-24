-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'tokyonight_night'

config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.5
config.macos_window_background_blur = 20
config.font_size = 13
config.initial_rows = 40
config.initial_cols = 100

-- and finally, return the configuration to wezterm
return config
