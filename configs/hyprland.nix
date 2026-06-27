{ config, pkgs, ... }:

{
  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland/hyprland.lua;
    "hypr/hyprland/animations.lua".source = ./hyprland/hyprland/animations.lua;
    "hypr/hyprland/autostart.lua".source = ./hyprland/hyprland/autostart.lua;
    "hypr/hyprland/window_rules.lua".source = ./hyprland/hyprland/window_rules.lua;
    "hypr/hyprsplit/init.lua".source = ./hyprland/hyprsplit/init.lua;
  };

  xdg.configFile."uwsm/env-hyprland".text = ''
    export XCURSOR_SIZE=16
    export HYPRCURSOR_SIZE=16
  '';

  wayland.windowManager.hyprland.systemd.enable = false;
}
