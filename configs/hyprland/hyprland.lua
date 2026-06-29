-- wiki: https://wiki.hypr.land/Configuring/Start/

--------------------------------------------------------------------------------
-- SOURCE EXTRA CONFIGS
--------------------------------------------------------------------------------

require("hyprland.animations")
require("hyprland.autostart")
require("hyprland.window_rules")

local hs = require("hyprsplit")

-- Configure hyprsplit options natively
hs.config({
	num_workspaces = 10,
	persistent_workspaces = false,
})

--------------------------------------------------------------------------------
-- MONITORS
--------------------------------------------------------------------------------
-- Format: hl.monitor({ "NAME", "RESOLUTION", "POSITION", "SCALE" })
hl.monitor({ output = "DP-3", mode = "1920x1080@260", position = "auto", scale = 1 })
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

--------------------------------------------------------------------------------
-- AUTOSTART VARIABLES & EXECUTIONS
--------------------------------------------------------------------------------
local terminal = "kitty"
local menu = "rofi -show drun"

--------------------------------------------------------------------------------
-- LOOK AND FEEL (Core Configuration Object)
--------------------------------------------------------------------------------
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 10,
		border_size = 0,
		resize_on_border = false,
		allow_tearing = false,
		layout = "scrolling",
	},

	decoration = {
		rounding = 18,
		rounding_power = 2.5,
		active_opacity = 0.94,
		inactive_opacity = 0.88,
		dim_inactive = 0,
		dim_strength = 0.15,
		shadow = {
			enabled = false,
			range = 7,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 4,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	scrolling = {
		column_width = 0.8,
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
		disable_splash_rendering = 1,
		focus_on_activate = 1,
		vrr = 3,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = -0.3,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = false,
		},
	},
})

--------------------------------------------------------------------------------
-- KEYBINDINGS
--------------------------------------------------------------------------------
local mainMod = "SUPER"

-- Basic Application Launches
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + G", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.local/bin/wallselect"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.local/bin/cliphist-rofi-img"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty --class nvim-float -e nvim"))

-- Special Script Invoking Executions
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty --class yazi-float -e ~/.config/hypr/scripts/yazi.sh"))

-- Monitor Controls
hl.bind(mainMod .. " + semicolon", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.window.move({ monitor = "+1" }))

-- workspace management
hl.bind(mainMod .. " + k", hs.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + j", hs.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + k", hs.dsp.window.move({ workspace = "prev" }))
hl.bind(mainMod .. " + SHIFT + j", hs.dsp.window.move({ workspace = "next" }))

for i = 1, 10 do
	local key = i % 10
	if i <= 3 then
		hl.bind(mainMod .. " + " .. key, hs.dsp.focus({ workspace = i }))
	end
	hl.bind(mainMod .. " + SHIFT + " .. key, hs.dsp.window.move({ workspace = i, follow = false }))
end

-- changing focus
hl.bind(mainMod .. " + h", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + l", hl.dsp.layout("focus r"))

-- swapping places
hl.bind(mainMod .. " + SHIFT + h", hl.dsp.layout("swapcol l"))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.layout("swapcol r"))

-- gestures
hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

-- exit logic
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("uwsm stop"))

-- Mouse Bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Multimedia Keys (Audio & Brightness)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media Playback Controls

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
