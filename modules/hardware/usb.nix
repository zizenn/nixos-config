{ ... }:
{
  # USB input devices get autosuspended (losing keyboards/mice) and go
  # missing after suspend/resume — both halves of the same fix live here.
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eyboard*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eypad*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Mm]ouse*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Hh]id*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Tt]ouchpad*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="input", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="block", KERNEL=="sd*", SUBSYSTEMS=="usb", ATTR{queue/scheduler}="bfq"
    ACTION=="change", SUBSYSTEM=="block", KERNEL=="sd*", SUBSYSTEMS=="usb", ATTR{queue/scheduler}="bfq"
  '';

  systemd.services.fix-usb-input-after-resume = {
    enable = true;
    description = "Fix USB input devices after suspend/resume";
    after = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    wants = [
      "suspend.target"
      "hibernate.target"
      "hybrid-sleep.target"
    ];
    before = [ "post-resume.target" ];
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
}
