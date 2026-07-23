{ config, pkgs, inputs, ... }:

let
  inherit (pkgs.stdenv.hostPlatform) system;

  fragments = [
    ./config/01-input.kdl
    ./config/02-outputs.kdl
    ./config/03-layout.kdl
    ./config/04-main.kdl
    ./config/05-window-rules.kdl
    ./config/06-binds.kdl
  ];
  configText = builtins.concatStringsSep "\n" (map builtins.readFile fragments);
in
{
  home.packages = with pkgs; [
    hypridle
    hyprlock
    swaylock
    inputs.wlctl.packages.${system}.default
  ];

  xdg.configFile = {
    "niri/config.kdl".text = configText;
    "hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
