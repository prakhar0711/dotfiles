-- Monitors
hl.monitor({ output = "eDP-1", mode = "2560x1600@240", position = "0x0", scale = "1.25" })
-- hl.monitor({ output = "eDP-2", mode = "2560x1600@240", position = "0x0", scale = "1.25" })

-- General Look, Decoration & Hardware Configs
hl.config({
	animations = {
		enabled = true,
		bezier = {
			{ "smoothResize", 0.25, 1, 0.5, 1 },
		},

		-- Apply the curve to windows and resizes
		-- syntax: { event, enable, speed, curve, style }
		animation = {
			{ "windows", true, 4, "smoothResize", "slide" },
			{ "windowsMove", true, 4, "smoothResize" },
		},
	},
	general = {
		gaps_in = 2,
		gaps_out = 6,
		border_size = 1,
		col = { active_border = "rgba(33ccffee)", inactive_border = "rgba(595959aa)" },
		resize_on_border = true,
		hover_icon_on_border = true,
		extend_border_grab_area = 15,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 6,
		rounding_power = 2,
		-- active_opacity = 1,
		-- inactive_opacity = 1,
		shadow = { enabled = true, range = 5, render_power = 5, color = "rgba(1a1a1aee)" },
		blur = {
			enabled = true,
			size = 10,
			passes = 3,
			noise = 0,
			vibrancy = 0.1696,
			contrast = 1.5,
			new_optimizations = true,
			ignore_opacity = true,
			brightness = 0.9,
			xray = false,
			popups = true,
		},
	},
	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = 0,
		accel_profile = "flat",
		touchpad = { natural_scroll = true, tap_to_click = true },
	},
	dwindle = { preserve_split = true, smart_split = false, smart_resizing = true },
	master = { new_status = "master" },
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 1,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		animate_manual_resizes = false,
	},
	debug = { vfr = true },
	cursor = {
		no_hardware_cursors = false,
		enable_hyprcursor = true,
		sync_gsettings_theme = true,
	},
})

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5, accel_profile = "flat" })

-- =============================================================================
-- BEZIER CURVES & ANIMATIONS
-- =============================================================================
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

hl.animation({ leaf = "global", enabled = true, speed = 8, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 3.5, bezier = "easeOutQuint", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.5, bezier = "linear", style = "popin 85%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 2, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.8, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.2, bezier = "easeOutQuint", style = "slide" })

-- Terminal specific opacity rules
-- Or if you use Alacritty:
-- hl.windowrulev2({ rule = "opacity 0.9 0.5", class = "^(Alacritty)$" })
