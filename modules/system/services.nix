{ config, lib, pkgs, ... }: {
  services = {
    dbus.enable = true;
    upower.enable = true;
    blueman.enable = true;
    udisks2.enable = true;
    openssh.enable = true;
    timesyncd.enable = true;
    elephant.enable = true;

    pipewire = {
      enable = true;
      audio.enable = true;
      pulse.enable = true;
      wireplumber.enable = true;
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
  services.udev.extraRules = ''
    # Disable USB autosuspend for input devices (keyboards, mice, HID)
    ACTION=="add", SUBSYSTEM=="usb", ATTR{product}=="*[Kk]eyboard*|*[Kk]eypad*|*[Mm]ouse*|*[Hh]id*|*[Tt]ouchpad*", ATTR{power/control}="on"
    ACTION=="add", SUBSYSTEM=="input", ATTR{power/control}="on"
  '';

  systemd.services.fix-usb-input-after-resume = {
    enable = true;
    description = "Fix USB input devices after suspend/resume";
    after = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
    wants = [ "suspend.target" "hibernate.target" "hybrid-sleep.target" ];
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
    config = {
      font-name = "JetBrainsMono Nerd Font";
      font-size = 14;
      drm = true;
      hwaccel = true;
    };
  };

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];
}
