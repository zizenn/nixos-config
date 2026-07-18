local in_zen = false
local saved_gaps_in = nil
local saved_gaps_out = nil

local function toggle_zen()
	if in_zen then
		if saved_gaps_in ~= nil then
			hl.config({ general = { gaps_in = saved_gaps_in } })
		end
		if saved_gaps_out ~= nil then
			hl.config({ general = { gaps_out = saved_gaps_out } })
		end
		hl.exec_cmd("pkill -f 'waybar.*waybar-zen'")
		hl.exec_cmd("waybar")
		in_zen = false
	else
		saved_gaps_in = hl.get_config("general.gaps_in")
		saved_gaps_out = hl.get_config("general.gaps_out")
		hl.config({ general = { gaps_in = 2, gaps_out = 0 } })
		hl.exec_cmd(
			"pkill waybar; waybar -c /home/zizenn/.config/waybar-zen/config.jsonc -s /home/zizenn/.config/waybar-zen/style.css")
		in_zen = true
	end
end

hl.bind("SUPER + Z", toggle_zen)
