{ config, pkgs, ... }:

{
  xdg.configFile = {
    "waybar/config.jsonc".source = ./waybar/config.jsonc;
    "waybar/style.css".source = ./waybar/style.css;
    "waybar/scrolling-mpris.py".source = ./waybar/scrolling-mpris.py;
  };
}
