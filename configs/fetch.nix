{ config, pkgs, ... }: {
  programs.fetch = {
    enable = true;
    labelColor = "red";
    info = [
      "os"
      "kernel"
      "uptime"
    ];
    speed = 1.0;
    spin = "xy";
  };
}
