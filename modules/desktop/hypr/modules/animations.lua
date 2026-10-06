-- Custom fluid curves for a premium look
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- The Fluid Easing Curve (Fast start, buttery deceleration)
hl.curve("fluidWorkspace", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })

-- Default springs
-- hl.curve("easy", { type = "spring", mass = 1, stiffness = 238.1191, dampening = 24.21279333 })
hl.curve("easy", { type = "spring", mass = 0.6, stiffness = 430.1191, dampening = 34.21279333 })

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })

-- windows
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, spring = "easy", style = "popin 87%" })

-- fades
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })

-- layers
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })

-- fadeXlayers
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })

-- workspaces
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.4, spring = "easy", style = "slidevert" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 3.4, spring = "easy", style = "slidevert" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 3.4, spring = "easy", style = "slidevert" })

-- zoom
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })
