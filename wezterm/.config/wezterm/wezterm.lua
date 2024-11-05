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
				File = "/home/pp/wallpapers/burning_cherry.jpeg",
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
	webgpu_preferred_adapter = {
		backend = "Vulkan",
		device = 7446,
		device_type = "DiscreteGpu",
		driver = "NVIDIA",
		driver_info = "565.57.01",
		name = "NVIDIA GeForce MX330",
		vendor = 4318,
	},
	front_end = "WebGpu",
}

return config
