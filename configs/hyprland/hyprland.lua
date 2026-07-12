-- wiki: https://wiki.hypr.land/Configuring/Start/

--------------------------------------------------------------------------------
-- SOURCE EXTRA CONFIGS
--------------------------------------------------------------------------------

require("hyprland.animations")
require("hyprland.autostart")
require("hyprland.window_rules")
require("hyprland.monitors")
require("hyprland.config")

hs = require("hyprsplit")

-- Configure hyprsplit options natively
hs.config({
	num_workspaces = 10,
	persistent_workspaces = false,
})

require("hyprland.zen")
require("hyprland.bindings")
