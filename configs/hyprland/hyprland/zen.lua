local in_zen = false
local saved_gaps_in = nil
local saved_gaps_out = nil

local waybar_zen_config = "$HOME/.config/waybar-zen/config.jsonc"
local waybar_zen_style  = "$HOME/.config/waybar-zen/style.css"

local function toggle_zen()
	if in_zen then
		if saved_gaps_in ~= nil then
			hl.config({ general = { gaps_in = saved_gaps_in } })
		end
		if saved_gaps_out ~= nil then
			hl.config({ general = { gaps_out = saved_gaps_out } })
		end
		hl.exec_cmd("pkill -f 'waybar.*waybar-zen'")
		hl.exec_cmd("waybar &")
		hl.exec_cmd("mako")
		in_zen = false
	else
		saved_gaps_in = hl.get_config("general.gaps_in")
		saved_gaps_out = hl.get_config("general.gaps_out")
		hl.config({ general = { gaps_in = 2, gaps_out = 0 } })
		hl.exec_cmd("pkill waybar")
		hl.exec_cmd("waybar -c " .. waybar_zen_config .. " -s " .. waybar_zen_style .. " &")
		hl.exec_cmd("pkill mako")
		in_zen = true
	end
end

hl.bind("SUPER + Z", toggle_zen)
