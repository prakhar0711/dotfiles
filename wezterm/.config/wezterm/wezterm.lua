local wezterm = require("wezterm")
local act = wezterm.action
config = wezterm.config_builder()
config = {
	freetype_load_flags = "NO_HINTING",
	-- Disable bold fonts
	bold_brightens_ansi_colors = false,
	font = wezterm.font_with_fallback({ "ColonMonoW01 Nerd Font", "Drafting* Mono", "OverpassM Nerd Font" }),
	line_height = 1.11,
	font_size = 16,
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	color_scheme = "Rosé Pine (base16)",
	background = {
		-- {
		-- 	source = {
		-- 		File = "/home/pp/wallpapers/burning_cherry.jpeg",
		-- 	},
		-- 	hsb = { hue = 1, saturation = 0.8, brightness = 0.08 },
		-- 	width = "100%",
		-- 	height = "100%",
		-- },
		{
			-- source = { Color = "#01121a" },
			source = { Color = "#000000" },

			width = "100%",
			height = "100%",
			opacity = 0.5,
		},
	},
	window_padding = {
		left = 5,
		right = 5,
		top = 2,
		bottom = 2,
	},
	colors = {
		-- cursor_bg = "#2b8f61",
		cursor_bg = "#FF4971",
		-- background = "#000000",
	},
	keys = {

		{
			key = "h",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Left"),
		},

		-- Ctrl+Shift+l to activate pane to the right
		{
			key = "l",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Right"),
		},

		-- Ctrl+Shift+k to activate pane above
		{
			key = "k",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Up"),
		},

		-- Ctrl+Shift+j to activate pane below
		{
			key = "j",
			mods = "CTRL|SHIFT",
			action = act.ActivatePaneDirection("Down"),
		},
		{
			key = '"',
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "|",
			mods = "CTRL|SHIFT|ALT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
	},
}

return config
