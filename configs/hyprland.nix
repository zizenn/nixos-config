{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland/hyprland.lua;
    "hypr/hyprland/animations.lua".source = ./hyprland/hyprland/animations.lua;
    "hypr/hyprland/autostart.lua".source = ./hyprland/hyprland/autostart.lua;
    "hypr/hyprland/window_rules.lua".source = ./hyprland/hyprland/window_rules.lua;
    "hypr/hyprland/monitors.lua".source = ./hyprland/hyprland/monitors.lua;
    "hypr/hyprland/config.lua".source = ./hyprland/hyprland/config.lua;
    "hypr/hyprland/bindings.lua".source = ./hyprland/hyprland/bindings.lua;
    "hypr/hyprland/zen.lua".source = ./hyprland/hyprland/zen.lua;
    "hypr/hypridle.conf".source = ./hyprland/hyprland/hypridle.conf;
    "hypr/scripts/layout-toggle.sh".source = ./hyprland/scripts/layout-toggle.sh;
  };

  wayland.windowManager.hyprland.systemd.enable = false;
}
