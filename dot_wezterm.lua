-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.
-- setting tmux-style "leader"
config.leader = { key = 'b', mods = 'CTRL', timeout_milliseconds = 1500 }

-- tmux split shortcuts 
config.keys = {
  -- Split horizontal (right) with 'Ctrl-B' then '%'
  { key = '%', mods = 'LEADER', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
   -- Split vertical (down) with 'Ctrl-B' then '"'
 { key = '"', mods = 'LEADER', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
}

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 34

-- or, changing the font size and color scheme.
config.font_size = 15

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

config.window_close_confirmation = 'NeverPrompt'

-- Finally, return the configuration to wezterm:
return config
