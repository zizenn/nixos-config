{ config, pkgs, ... }: {
  programs.fetch = {
    enable = true;
    labelColor = "red";
    info = [
      "os"
      "host"
      "kernel"
      "uptime"
    ];
    speed = 1.0;
    spin = "xy";
  };
}
