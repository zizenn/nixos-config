{
  config,
  lib,
  pkgs,
  ...
}:
{
  services = {
    dbus.enable = true;
    upower.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    timesyncd.enable = true;
    elephant.enable = true;
    fstrim.enable = true;
    tailscale.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
            X11Forwarding = true;
      };
    };
  };

  systemd.packages = [ pkgs.cloudflare-warp ];

  services.logind = {
    settings = {
      Login = {
        HandlePowerKey = "ignore";
        HandleLidSwitch = "suspend";
        HandleLidSwitchExternalPower = "lock";
        LidSwitchIgnoreInhibited = "no";
      };
    };
  };

  # Fix USB input devices not working after suspend/resume
  # Force BFQ I/O scheduler for external USB block devices
  services.udev.extraRules = ''
    # Disable USB autosuspend for input devices (keyboards, mice, HID)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eyboard*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eypad*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Mm]ouse*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Hh]id*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Tt]ouchpad*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="input", ATTR{power/control}="on"
    # BFQ scheduler for USB mass storage (e.g. external SSD)
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
      # Ensure USB autosuspend is disabled for all devices
      for dev in /sys/bus/usb/devices/*/power/control; do
        echo "on" > "$dev" 2>/dev/null || true
      done
      # Re-probe input devices via udev
      udevadm trigger --subsystem-match=usb --action=change
      udevadm trigger --subsystem-match=input --action=change
    '';
    serviceConfig = {
      Type = "oneshot";
    };
  };

  services.kmscon = {
    enable = true;
    useXkbConfig = true;
    config = {
      font-name = "JetBrainsMono Nerd Font";
      font-size = 14;
      font-engine = "pango";
      drm = true;
      hwaccel = false;
      term = "xterm-256color";
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
