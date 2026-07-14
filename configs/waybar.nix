{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar.overrideAttrs (oldAttrs: {
      # Ensures playerctl is explicitly available to the bar's shell scripts
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.playerctl
        pkgs.python3
      ];
    });
  };

  xdg.configFile = {
    "waybar/config.jsonc".source = ./waybar/config.jsonc;
    "waybar/style.css".source = ./waybar/style.css;

    # Force Nix to create the script file with executable permissions
    "waybar/scrolling-mpris.py" = {
      source = ./waybar/scrolling-mpris.py;
      executable = true;
    };
  };
}
