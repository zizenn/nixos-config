{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland.lua;
    "hypr/hyprland/animations.lua".source = ./hyprland/animations.lua;
    "hypr/hyprland/autostart.lua".source = ./hyprland/autostart.lua;
    "hypr/hyprland/window_rules.lua".source = ./hyprland/window_rules.lua;
    "hypr/hyprland/monitors.lua".source = ./hyprland/monitors.lua;
    "hypr/hyprland/config.lua".source = ./hyprland/config.lua;
    "hypr/hyprland/bindings.lua".source = ./hyprland/bindings.lua;
    "hypr/hyprland/zen.lua".source = ./hyprland/zen.lua;
    "hypr/hypridle.conf".source = ./hyprland/hypridle.conf;
    "hypr/scripts/layout-toggle.sh".source = ./scripts/layout-toggle.sh;
  };

  wayland.windowManager.hyprland.systemd.enable = false;
}
