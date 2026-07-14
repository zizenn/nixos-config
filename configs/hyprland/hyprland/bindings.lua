local terminal = "kitty"
local menu = "rofi -show drun"
local mainMod = "SUPER"

-- Basic Application Launches
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + G", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + Space", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = 0 }))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("wallpaper-pick"))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.local/bin/cliphist-rofi-img"))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obsidian"))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd("wleave"))

-- save session
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprsession save"))

-- Special Script Invoking Executions
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty --class yazi-float -e ~/.config/hypr/scripts/yazi.sh"))

-- Monitor Controls
hl.bind(mainMod .. " + semicolon", hl.dsp.focus({ monitor = "+1" }))
hl.bind(mainMod .. " + SHIFT + semicolon", hl.dsp.window.move({ monitor = "+1" }))

-- workspace management
hl.bind(mainMod .. " + k", hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ workspace = "prev" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ workspace = "next" }))

for i = 1, 10 do
      local key = i % 10
      if i <= 9 then
            hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
      end
      hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- changing focus
hl.bind(mainMod .. " + h", hl.dsp.layout("focus l"))
hl.bind(mainMod .. " + l", hl.dsp.layout("focus r"))

-- toggle focus between floating and tiled windows
hl.bind(mainMod .. " + Tab", hl.dsp.layout("focuswindow floating"))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.layout("focuswindow tiled"))

-- launch aerc (floating via aerc-todo class rule)
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("kitty --class aerc-todo -e aerc"))

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
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("hyprsession save; uwsm stop"))

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
