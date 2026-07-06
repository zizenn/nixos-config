{ config, pkgs, ... }: {
  programs.fetch = {
    enable = true;
    labelColor = "blue";
    info = [
      "os"
      "host"
      "kernel"
      "uptime"
      "shell"
      "wm"
      "terminal"
      "cpu"
      "gpu"
      "ip"
      "colors"
    ];
    speed = 1.0;
    spin = "xy";
  };
}
