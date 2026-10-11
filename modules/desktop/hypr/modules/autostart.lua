-- Under UWSM, launch apps as systemd scopes via `uwsm app --` instead of
-- plain child processes of the compositor unit.
hl.on("hyprland.start", function()
	hl.exec_cmd("uwsm app -- noctalia --daemon")
	hl.exec_cmd("uwsm app -- kitty --single-instance --listen-on unix:/tmp/kitty-zizenn --start-as hidden --detach --session none")
	hl.exec_cmd("uwsm app -- vesktop")
	hl.exec_cmd("uwsm app -- zen")
end)
