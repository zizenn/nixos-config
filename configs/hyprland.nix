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
    "hypr/hyprsplit/init.lua".source = ./hyprland/hyprsplit/init.lua;
    "hypr/hypridle.conf".source = ./hyprland/hyprland/hypridle.conf;
  };

  xdg.configFile."uwsm/env-hyprland".text = ''
    export XCURSOR_SIZE=24
    export HYPRCURSOR_SIZE=24
  '';

  wayland.windowManager.hyprland.systemd.enable = false;
}
