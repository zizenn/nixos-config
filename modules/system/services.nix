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
}
