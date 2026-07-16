{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
  };

  xdg.configFile = {
    "waybar/config.jsonc".source = ./waybar/config.jsonc;
    "waybar/style.css".source = ./waybar/style.css;
    "waybar-zen/config.jsonc".source = ./waybar-zen/config.jsonc;
    "waybar-zen/style.css".source = ./waybar-zen/style.css;
  };
}
