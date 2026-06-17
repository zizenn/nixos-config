{ config, pkgs, ... }:

let
  luaDir = ".config/hypr";
in
{
  xdg.configFile = {
    "${luaDir}/hyprland.lua".text = ''
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
          persistent_workspaces = false
      })

      --------------------------------------------------------------------------------
      -- MONITORS
      --------------------------------------------------------------------------------
      -- Format: hl.monitor({ "NAME", "RESOLUTION", "POSITION", "SCALE" })
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

      --------------------------------------------------------------------------------
      -- AUTOSTART VARIABLES & EXECUTIONS
      --------------------------------------------------------------------------------
      local terminal = "kitty"
      local menu = "rofi -show drun"
      local bar = "waybar"

      --------------------------------------------------------------------------------
      -- ENVIRONMENT VARIABLES
      --------------------------------------------------------------------------------

      hl.env("XCURSOR_SIZE", "16")
      hl.env("HYPRCURSOR_SIZE", "16")

      --------------------------------------------------------------------------------
      -- LOOK AND FEEL (Core Configuration Object)
      --------------------------------------------------------------------------------
      hl.config({
          general = {
              gaps_in = 5,
              gaps_out = 15,
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
          action = "workspace"
      })


      -- exit logic
      hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))

      -- Mouse Bindings
      hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
      hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

      -- Multimedia Keys (Audio & Brightness)
      hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
      hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
      hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
      hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
      hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })


      -- Media Playback Controls

      -- Requires playerctl
      hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
      hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
      hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
    '';

    "${luaDir}/hyprland/animations.lua".text = ''
      -- animations
      hl.curve("expressiveFastSpatial", {
          type = "bezier",
          points = {{0.42, 1.67}, {0.21, 0.90}}
      })
      hl.curve("expressiveSlowSpatial", {
          type = "bezier",
          points = {{0.39, 1.29}, {0.35, 0.98}}
      })
      hl.curve("expressiveDefaultSpatial", {
          type = "bezier",
          points = {{0.38, 1.21}, {0.22, 1.00}}
      })
      hl.curve("emphasizedDecel", {
          type = "bezier",
          points = {{0.05, 0.7}, {0.1, 1}}
      })
      hl.curve("emphasizedAccel", {
          type = "bezier",
          points = {{0.3, 0}, {0.8, 0.15}}
      })
      hl.curve("standardDecel", {
          type = "bezier",
          points = {{0, 0}, {0, 1}}
      })
      hl.curve("menu_decel", {
          type = "bezier",
          points = {{0.1, 1}, {0, 1}}
      })
      hl.curve("menu_accel", {
          type = "bezier",
          points = {{0.52, 0.03}, {0.72, 0.08}}
      })
      hl.curve("stall", {
          type = "bezier",
          points = {{1, -0.1}, {0.7, 0.85}}
      })
      -- Configs
      -- windows
      hl.animation({
          leaf = "windowsIn",
          enabled = true,
          speed = 3,
          bezier = "emphasizedDecel",
          style = "popin 80%"
      })
      hl.animation({
          leaf = "fadeIn",
          enabled = true,
          speed = 3,
          bezier = "emphasizedDecel"
      })
      hl.animation({
          leaf = "windowsOut",
          enabled = true,
          speed = 2,
          bezier = "emphasizedDecel",
          style = "popin 90%"
      })
      hl.animation({
          leaf = "fadeOut",
          enabled = true,
          speed = 2,
          bezier = "emphasizedDecel"
      })
      hl.animation({
          leaf = "windowsMove",
          enabled = true,
          speed = 3,
          bezier = "emphasizedDecel",
          style = "slide"
      })
      hl.animation({
          leaf = "border",
          enabled = true,
          speed = 10,
          bezier = "emphasizedDecel"
      })

      -- layers
      hl.animation({
          leaf = "layersIn",
          enabled = true,
          speed = 2.7,
          bezier = "emphasizedDecel",
          style = "popin 93%"
      })
      hl.animation({
          leaf = "layersOut",
          enabled = true,
          speed = 2.4,
          bezier = "menu_accel",
          style = "popin 94%"
      })
      -- fade
      hl.animation({
          leaf = "fadeLayersIn",
          enabled = true,
          speed = 0.5,
          bezier = "menu_decel"
      })
      hl.animation({
          leaf = "fadeLayersOut",
          enabled = true,
          speed = 2.7,
          bezier = "stall"
      })
      -- workspaces
      hl.animation({
          leaf = "workspaces",
          enabled = true,
          speed = 7,
          bezier = "menu_decel",
          style = "slidevert"
      })
      -- specialWorkspace
      hl.animation({
          leaf = "specialWorkspaceIn",
          enabled = true,
          speed = 2.8,
          bezier = "emphasizedDecel",
          style = "slidevert"
      })
      hl.animation({
          leaf = "specialWorkspaceOut",
          enabled = true,
          speed = 1.2,
          bezier = "emphasizedAccel",
          style = "slidevert"
      })
      -- zoom
      hl.animation({
          leaf = "zoomFactor",
          enabled = true,
          speed = 3,
          bezier = "standardDecel"
      })
    '';

    "${luaDir}/hyprland/autostart.lua".text = ''
      local terminal = "kitty"
      local menu = "wofi -n"
      local bar = "waybar"

      hl.on("hyprland.start", function ()
          -- hyprpolkitagent and pywal
          hl.exec_cmd("matugen image ~/.wallpaper")
          hl.exec_cmd("systemctl --user start hyprpolkitagent")
          hl.exec_cmd("xhost +si:localuser:root")

          -- xdg desktop portal
          hl.exec_cmd("killall -9 xdg-desktop-portal-hyprland xdg-desktop-portal")
          hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
          hl.exec_cmd("/usr/lib/xdg-desktop-portal &")

          -- clipboard
          hl.exec_cmd("wl-paste --type text --watch cliphist store")
          hl.exec_cmd("wl-paste --type image --watch cliphist store")

          -- wallpaper
          hl.exec_cmd("awww-daemon")

          -- bar
          hl.exec_cmd(bar)

      end)
    '';

    "${luaDir}/hyprland/window_rules.lua".text = ''
      hl.window_rule({
          match = { class = ".*" },
          suppress_event = "maximize",
      })

      hl.window_rule({
          match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
          no_focus = true,
      })

      hl.window_rule({
          match = { class = "hyprland-run" },
          move = "20 monitor_h-120",
          float = true,
      })

      hl.window_rule({ match = { initial_class = "^(com.github.martenad.dragon)$" }, float = true, pin = true, size = "200 200", center = true })

      hl.window_rule({
          match = { class = "yazi-float" },
          float = true,
          size = "1280 720",
          center = true,
      })
    '';
  };
}
