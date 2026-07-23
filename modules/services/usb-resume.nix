{lib, ...}: {
  nixos.modules.base = {
    systemd.services.fix-usb-input-after-resume = {
      enable = true;
      description = "Fix USB input devices after suspend/resume";
      after = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
      wants = ["suspend.target" "hibernate.target" "hybrid-sleep.target"];
      before = ["post-resume.target"];
      script = ''
        sleep 3
        for dev in /sys/bus/usb/devices/*/power/control; do
          echo "on" > "$dev" 2>/dev/null || true
        done
        udevadm trigger --subsystem-match=usb --action=change
        udevadm trigger --subsystem-match=input --action=change
      '';
      serviceConfig.Type = "oneshot";
    };
  };
}
