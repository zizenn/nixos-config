local mainMod = "SUPER"

-- terminal
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))

-- close
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- noctalia binds
hl.bind("ALT + Space", hl.dsp.exec_cmd("noctalia msg panel-toggle launcher"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("noctalia msg panel-toggle clipboard"))
hl.bind(mainMod .. " + COMMA", hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("noctalia msg screenshot-region"))
hl.bind(mainMod .. " + ALT + L", hl.dsp.exec_cmd("noctalia msg session lock"))

-- apps binds
-- the floating apps
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty --class yazi-float -e yazi"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty --class aerc-todo -e aerc"))
hl.bind(mainMod .. " + X", hl.dsp.exec_cmd("kitty --class wiremix-float -e wiremix"))
-- normal apps
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))

-- window stuff
hl.bind(mainMod .. " + G", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())

-- resize
hl.bind(mainMod .. " + R", hl.dsp.layout("colresize +conf"))

-- overview (RN IT ISNT WORKING CUZ PLUGIN IS BROKE)
hl.bind("SUPER + Y", function()
	hl.plugin.scrolloverview.overview("toggle all")
end)

-- focusing and moving windows
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. "+ SHIFT + H", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. "+ SHIFT + L", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + I", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. "+ SHIFT + I", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + U", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. "+ SHIFT + U", hl.dsp.window.swap({ direction = "down" }))

-- workspace controls
hl.bind(mainMod .. " + J", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ workspace = "-1" }))

-- fullscreen
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle", layout_aware = true }))

-- workspace switch 1-10
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- scratchpad
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- resize via mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- volume + brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("noctalia msg volume-up"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("noctalia msg volume-down"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("noctalia msg volume-mute"), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("noctalia msg mic-mute"), { locked = true, repeating = true })

-- media binds
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("noctalia msg media next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("noctalia msg media stop"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("noctalia msg media toggle"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("noctalia msg media previous"), { locked = true })

-- exit hyprland
hl.bind(
	mainMod .. " + M",
	hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")
)
