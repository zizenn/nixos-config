{ config, pkgs, ... }:

{
  xdg.configFile."quickshell".source = ./quickshell;

  home.packages = with pkgs; [
    quickshell
  ];
}
