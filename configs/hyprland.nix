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

    "${luaDir}/hyprsplit/init.lua".text = ''
      ---@class Hyprsplit
      ---@field protected _config Hyprsplit.Config
      ---@field protected monitor_priority_list string[]
      local hyprsplit = {
          ---@class Hyprsplit.Config
          _config = {
              num_workspaces = 10,
              persistent_workspaces = false,
              force_monitor_priority = false,
          },
          monitor_priority_list = {},
          dsp = {
              window = {},
              workspace = {},
          },
      }

      ---@param formatString string
      local function log(formatString, ...)
          print(string.format("[hyprsplit] " .. formatString, ...))
      end

      ---@param formatString string
      local function notify_error(formatString, ...)
          local error = string.format("[hyprsplit] error: " .. formatString, ...)
          log(error)
          hl.notification.create({
              text = error,
              duration = "10000",
              icon = 3,
              color = "rgb(ff0000)",
          })
      end

      ---@class Hyprsplit.MonitorRange
      ---@field base integer
      ---@field min integer
      ---@field max integer
      local MonitorRange = {}
      ---@param monitor HL.Monitor
      ---@return Hyprsplit.MonitorRange
      function MonitorRange:new(monitor)
          local base = -1
          if #hyprsplit.monitor_priority_list == 0 and not hyprsplit._config.force_monitor_priority then
              base = monitor.id
          else
              for i, monitor_selector in ipairs(hyprsplit.monitor_priority_list) do
                  if monitor.name == monitor_selector or monitor.description == monitor_selector then
                      base = i - 1
                  end
              end
              if base == -1 then
                  local unmappedMonitors = {}
                  for _, m in ipairs(hl.get_monitors()) do
                      if m ~= nil and not m.is_mirror and m.id ~= -1 then
                          local mapped = false
                          for _, monitor_selector in ipairs(hyprsplit.monitor_priority_list) do
                              if
                                  monitor.name == monitor_selector
                                  or monitor.description == monitor_selector
                              then
                                  mapped = true
                                  break
                              end
                          end
                          if not mapped then
                              table.insert(unmappedMonitors, m)
                          end
                      end
                  end

                  table.sort(unmappedMonitors, function(a, b)
                      return a.name < b.name
                  end)

                  for i, m in ipairs(unmappedMonitors) do
                      if monitor == m then
                          base = i - 1 + #hyprsplit.monitor_priority_list
                          log("auto assigning base %d to monitor %s", base, monitor.name)
                      end
                  end
              end
          end
          local min = (base * hyprsplit._config.num_workspaces) + 1
          local max = (base + 1) * hyprsplit._config.num_workspaces

          return setmetatable({ base = base, min = min, max = max }, {
              __index = self,
          })
      end
      ---@param num integer
      ---@return boolean
      function MonitorRange:contains(num)
          if type(num) ~= "number" then
              return false
          end
          return num >= self.min and num <= self.max
      end
      hyprsplit.MonitorRange = MonitorRange

      ---@param workspace_str string
      ---@return string
      function hyprsplit.get_workspace_string(workspace_str)
          local ws_id = 1
          local num_workspaces = hyprsplit._config.num_workspaces
          local active_monitor = hl.get_active_monitor()

          if active_monitor == nil or active_monitor.active_workspace == nil then
              log("missing monitor/active_active workspace in get_workspace?")
              return "0"
          end
          local range = MonitorRange:new(active_monitor)

          local workspace_int = math.tointeger(workspace_str)
          if workspace_str:sub(1, 1) == "+" or workspace_str:sub(1, 1) == "-" then
              if workspace_int == nil then
                  return tostring(active_monitor.active_workspace.id)
              end

              local local_current = active_monitor.active_workspace.id - range.min + 1
              ws_id = local_current + workspace_int

              ws_id = math.max(ws_id, 1)
              ws_id = math.min(ws_id, num_workspaces)
          elseif workspace_int ~= nil then
              ws_id = math.max(workspace_int, 1)
          elseif
              workspace_str:sub(1, 1) == "r"
              and (workspace_str:sub(2, 2) == "-" or workspace_str:sub(2, 2) == "+")
          then
              local plusminus_num = math.tointeger(workspace_str:sub(2))
              if plusminus_num == nil then
                  return tostring(active_monitor.active_workspace.id)
              end

              ws_id = active_monitor.active_workspace.id + plusminus_num

              if ws_id <= 0 then
                  ws_id = ((((ws_id - 1) % num_workspaces) + num_workspaces) % num_workspaces) + 1
              end
          elseif
              workspace_str:sub(1, 1) == "e"
              and (workspace_str:sub(2, 2) == "-" or workspace_str:sub(2, 2) == "+")
          then
              local plusminus_num = math.tointeger(workspace_str:sub(2))
              if plusminus_num == nil then
                  return tostring(active_monitor.active_workspace.id)
              end

              local valid_workspaces = {}
              for _, ws in ipairs(hl.get_workspaces()) do
                  if range:contains(ws.id) then
                      table.insert(valid_workspaces, ws)
                  end
              end

              local active_ws_index = -1
              for index, ws in ipairs(valid_workspaces) do
                  if ws.active then
                      active_ws_index = index
                  end
              end
              if active_ws_index == -1 then
                  return tostring(active_monitor.active_workspace.id)
              end

              local result_index = active_ws_index + plusminus_num
              if result_index < 1 then
                  result_index = 1
              elseif result_index > #valid_workspaces then
                  result_index = #valid_workspaces
              end

              return tostring(valid_workspaces[result_index].id)
          elseif workspace_str == "empty" then
              for i = range.min, range.max do
                  local ws = hl.get_workspace(i)
                  if ws == nil or ws.windows == 0 then
                      return tostring(i)
                  end
              end

              log("no empty workspace on monitor")
              return tostring(active_monitor.active_workspace.id)
          else
              return workspace_str
          end

          if ws_id > num_workspaces then
              ws_id = ((ws_id - 1) % num_workspaces) + 1
          end

          return tostring(range.min + ws_id - 1)
      end

      ---@param args table
      ---@return function
      function hyprsplit.dsp.focus(args)
          if args.workspace == nil then
              notify_error("dsp.focus: args.workspace is nil")
              return function() end
          end
          local workspace_arg = tostring(args.workspace)
          if workspace_arg then
              return function()
                  local ws_string = hyprsplit.get_workspace_string(workspace_arg)
                  local ws = hl.get_workspace(ws_string)
                  local active_monitor = hl.get_active_monitor()
                  if ws and active_monitor then
                      local range = MonitorRange:new(active_monitor)
                      if ws.monitor.id ~= active_monitor.id and range:contains(ws.id) then
                          log("workspace exists but is on the wrong monitor")
                          hyprsplit.ensure_good_workspaces()
                      end
                  end

                  if
                      hl.get_config("binds.workspace_back_and_forth")
                      and active_monitor
                      and active_monitor.active_workspace
                  then
                      local target_ws_id = math.tointeger(ws_string)
                      if target_ws_id == active_monitor.active_workspace.id then
                          log("dsp.focus: workspace_back_and_forth using previous_per_monitor")
                          hl.dispatch(hl.dsp.focus({
                              workspace = "previous_per_monitor",
                          }))
                          return
                      end
                  end

                  hl.dispatch(hl.dsp.focus({
                      workspace = ws_string,
                      on_current_monitor = true,
                  }))
              end
          else
              notify_error("dsp.focus: failed to convert args.workspace to string")
              return function() end
          end
      end

      ---@param args table
      ---@return function
      function hyprsplit.dsp.window.move(args)
          if args.workspace == nil then
              notify_error("dsp.window.move: args.workspace is nil")
              return function() end
          end
          local workspace = tostring(args.workspace)
          if workspace then
              return function()
                  args.workspace = hyprsplit.get_workspace_string(workspace)
                  hl.dispatch(hl.dsp.window.move(args))
              end
          else
              notify_error("dsp.window.move: failed to convert args.workspace to string")
              return function() end
          end
      end

      ---@param args table
      ---@return function
      function hyprsplit.dsp.workspace.swap_monitors(args)
          if not type(args.monitor1) == "string" or not type(args.monitor2) == "string" then
              return function()
                  notify_error("swap_monitors: monitor1 and monitor2 of type string are both required")
              end
          end
          return function()
              local monitor1 = hl.get_monitor(args.monitor1)
              local monitor2 = hl.get_monitor(args.monitor2)

              if monitor1 and monitor2 then
                  local windows1 = hl.get_workspace_windows(monitor1.active_workspace)
                  local windows2 = hl.get_workspace_windows(monitor2.active_workspace)

                  for _, window in ipairs(windows1) do
                      hl.dispatch(hl.dsp.window.move({
                          workspace = monitor2.active_workspace,
                          window = window,
                          follow = true,
                      }))
                  end
                  for _, window in ipairs(windows2) do
                      hl.dispatch(hl.dsp.window.move({
                          workspace = monitor1.active_workspace,
                          window = window,
                          follow = true,
                      }))
                  end
              end
          end
      end

      function hyprsplit.dsp.grab_rogue_windows()
          return function()
              hyprsplit.ensure_good_workspaces()
              local active_workspace = hl.get_active_workspace()
              if active_workspace == nil then
                  return
              end

              for _, window in ipairs(hl.get_windows()) do
                  if window.mapped and not window.workspace.special then
                      local in_good_workspace = false

                      for _, monitor in ipairs(hl.get_monitors()) do
                          local range = MonitorRange:new(monitor)

                          if range:contains(window.workspace.id) then
                              in_good_workspace = true
                          end
                      end

                      if not in_good_workspace then
                          log('moving window "%s" to active workspace %d', window.title, active_workspace.id)
                          hl.dispatch(hl.dsp.window.move({
                              workspace = active_workspace,
                              window = window,
                              follow = false,
                          }))
                      end
                  end
              end
          end
      end

      function hyprsplit.ensure_good_workspaces()
          local cursor_no_warps_orig = hl.get_config("cursor.no_warps")
          hl.config({ cursor = { no_warps = true } })

          local orig_focused_mon = hl.get_active_monitor()
          local monitors_active_workspaces = {}

          local monitors = hl.get_monitors()
          for _, m in ipairs(monitors) do
              if m ~= nil and not m.is_mirror and m.id ~= -1 then
                  local range = MonitorRange:new(m)
                  monitors_active_workspaces[m.name] = m.active_workspace.id

                  if not range:contains(m.active_workspace.id) then
                      log("%s base %d active workspace %d out of bounds, changing workspace to %d", m.name, range.base, m.active_workspace.id, range.min)
                      monitors_active_workspaces[m.name] = range.min
                      hl.dispatch(hl.dsp.focus({ workspace = range.min, on_current_monitor = true }))
                  end
              end
          end

          for _, m in ipairs(monitors) do
              if m ~= nil and not m.is_mirror and m.id ~= -1 then
                  local range = MonitorRange:new(m)

                  for _, ws in ipairs(hl.get_workspaces()) do
                      if ws.monitor and ws.monitor.id ~= m.id and range:contains(ws.id) then
                          log("workspace %d on monitor %d move to %s %d", ws.id, ws.monitor.id, m.name, range.base)
                          hl.dispatch(hl.dsp.workspace.move({ workspace = ws, monitor = m }))
                          hl.dispatch(hl.dsp.focus({ monitor = m }))
                          hl.dispatch(hl.dsp.focus({
                              workspace = monitors_active_workspaces[m.name],
                              on_current_monitor = true,
                          }))
                      end
                  end

                  if hyprsplit._config.persistent_workspaces then
                      for i = range.min, range.max do
                          hl.workspace_rule({
                              workspace = tostring(i),
                              persistent = true,
                              monitor = m.name,
                          })
                      end
                  end
              end
          end

          if orig_focused_mon then
              hl.dispatch(hl.dsp.focus({ monitor = orig_focused_mon }))
          end

          hl.config({ cursor = { no_warps = cursor_no_warps_orig } })
      end

      ---@param k string
      ---@param v any
      ---@param valid boolean|nil
      local function load_config_value(k, v, valid)
          if v ~= nil then
              if (valid == nil and type(v) == type(hyprsplit._config[k])) or valid then
                  hyprsplit._config[k] = v
              else
                  notify_error('config key "%s" invalid value "%s"', tostring(k), tostring(v))
              end
          end
      end

      ---@param config Hyprsplit.Config
      function hyprsplit.config(config)
          load_config_value("num_workspaces", config.num_workspaces, math.type(config.num_workspaces) == "integer" and config.num_workspaces >= 1)
          load_config_value("persistent_workspaces", config.persistent_workspaces)
          load_config_value("force_monitor_priority", config.force_monitor_priority)
      end

      ---@param key string
      ---@return any
      function hyprsplit.get_config(key)
          return hyprsplit._config[key]
      end

      ---@param priority table
      function hyprsplit.monitor_priority(priority)
          for _, monitor in ipairs(priority) do
              if type(monitor) == "string" then
                  log("assigning monitor priority: %s -> %d", monitor, #hyprsplit.monitor_priority_list)
                  table.insert(hyprsplit.monitor_priority_list, monitor)
              end
          end
      end

      hl.on("config.reloaded", function()
          hyprsplit.ensure_good_workspaces()
      end)

      hl.on("monitor.added", function(monitor)
          local cursor_no_warps_orig = hl.get_config("cursor.no_warps")
          hl.config({ cursor = { no_warps = true } })

          local orig_focused_mon = hl.get_active_monitor()
          hl.dispatch(hl.dsp.focus({ monitor = monitor }))
          local range = MonitorRange:new(monitor)
          hl.dispatch(hl.dsp.focus({ workspace = range.min, on_current_monitor = true }))
          hl.dispatch(hl.dsp.focus({ monitor = orig_focused_mon }))

          hl.config({ cursor = { no_warps = cursor_no_warps_orig } })

          hyprsplit.ensure_good_workspaces()
      end)

      hl.on("monitor.removed", function(monitor)
          if hyprsplit._config.persistent_workspaces then
              local range = MonitorRange:new(monitor)
              for i = range.min, range.max do
                  hl.workspace_rule({
                      workspace = tostring(i),
                      persistent = false,
                  })
              end
          end
      end)

      return hyprsplit
    '';
  };
}
