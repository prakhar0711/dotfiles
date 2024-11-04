local wezterm = require("wezterm")

config = wezterm.config_builder()
config = {
	font = wezterm.font("Drafting* Mono"),
	font_size = 16,
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_close_confirmation = "NeverPrompt",
	window_decorations = "RESIZE",
	-- color_scheme = "Monokai Remastered",
	color_scheme = "Rosé Pine (base16)",
	background = {
		{
			source = {
				File = "/home/pp/wallpapers/lakeside_sunset.png",
			},
			hsb = { hue = 1, saturation = 0.8, brightness = 0.03 },
			width = "100%",
			height = "100%",
		},
		{
			source = { Color = "#282c35" },

			width = "100%",
			height = "100%",
			opacity = 0.55,
		},
	},
	window_padding = {
		left = 5,
		right = 5,
		top = 2,
		bottom = 2,
	},
}

return config
