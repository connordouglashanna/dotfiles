-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 34

-- or, changing the font size and color scheme.
config.font_size = 11

-- Ricing "Usual Suspects"
config.window_padding = { left = 20, right = 20, top = 20, bottom = 20 }
config.window_decorations = "TITLE | RESIZE"
--config.window_background_opacity = 0.90
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.line_height = 1.1
config.default_cursor_style = "BlinkingBar"

config.font = wezterm.font_with_fallback {
	'MesloLGS Nerd Font Mono'
}
config.color_scheme = 'Catppuccin Mocha'

-- Finally, return the configuration to wezterm:
return config
