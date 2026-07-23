{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
  };

  xdg.configFile = {
    "waybar/config.jsonc".source = ./config.jsonc;
    "waybar/style.css".source = ./style.css;
    "waybar-zen/config.jsonc".source = ./zen/config.jsonc;
    "waybar-zen/style.css".source = ./zen/style.css;
  };

  home.packages = with pkgs; [ wttrbar ];
}
