{ config, pkgs, ... }:

{
  xdg.configFile = {
    "niri/config.kdl".source = ./config.kdl;
    "hypr/hypridle.conf".source = ./hypridle.conf;
  };
}
