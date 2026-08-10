-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- setting default shell to Bash on this Windows machine
config.default_prog = { "C:\\\\Program Files\\\\Git\\\\bin\\\\bash.exe", "--login", "-i"}

-- This is where you actually apply your config choices.

-- NOTE: the tmux-style leader (Ctrl-B) and its split bindings were removed.
-- Keys travel outside-in: WezTerm -> herdr -> shell. WezTerm's leader claimed
-- Ctrl-B first, so herdr (whose default prefix is also ctrl+b) never saw it and
-- its pane splits did nothing. herdr is the multiplexer now, so WezTerm yields
-- the prefix to it:
--   Ctrl-B  v        split vertical
--   Ctrl-B  -        split horizontal
--   Ctrl-B  x        close pane
--   Ctrl-B  h/j/k/l  focus pane left/down/up/right
-- To give WezTerm its own leader back, pick a chord herdr does not use
-- (e.g. CTRL+a) rather than restoring CTRL+b.

-- Disabling the confirmation message 
config.window_close_confirmation = 'NeverPrompt'

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 34

-- or, changing the font size and color scheme.
config.font_size = 12

-- Ricing "Usual Suspects"
-- Horizontal padding kept for readability; vertical trimmed, since 20px top +
-- 20px bottom costs roughly a row and a half of a 34-row window.
config.window_padding = { left = 20, right = 20, top = 4, bottom = 4 }
config.window_decorations = "TITLE | RESIZE"
--config.window_background_opacity = 0.90
-- herdr is the multiplexer, so WezTerm's tab bar is redundant chrome. Opening
-- WezTerm tabs as well would re-nest two multiplexers - the same class of
-- conflict as the old Ctrl-B collision. Disabled outright rather than
-- auto-hidden, since there is no case where we want it back.
config.enable_tab_bar = false
config.use_fancy_tab_bar = false  -- moot while the tab bar is off; harmless
config.line_height = 1.1
config.default_cursor_style = "BlinkingBar"

config.font = wezterm.font_with_fallback {
	'MesloLGS Nerd Font'
}
config.color_scheme = 'Catppuccin Mocha'

config.window_close_confirmation = 'NeverPrompt'

-- Finally, return the configuration to wezterm:
return config
