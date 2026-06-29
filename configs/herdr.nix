{ config, pkgs, ... }

{
  xdg.configFile.".config/herdr/config.toml".source = ./herdr/config.toml;
}
