-- loading plugins
hl.plugin.load("/run/current-system/sw/lib/libscrolloverview.so")

-- imports
-- require("modules.plugins")
require("modules.monitors")
require("modules.perms")
require("modules.programs")
require("modules.autostart")
require("modules.env")
require("modules.looks")
require("modules.animations")
require("modules.rules")
require("modules.config")
require("modules.misc")
require("modules.input")
require("modules.binds")

-- For Noctalia Color templates
require("noctalia").apply_theme()
