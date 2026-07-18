{ config, lib, pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = {
      name = "qtct";
    };
    style = {
      name = "kvantum";
      package = pkgs.qt6Packages.qtstyleplugin-kvantum;
    };
  };

  xdg.configFile = {
    "Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
    "Kvantum/Matugen.kvconfig" = {
      source = ./Matugen.kvconfig;
      force = true;
    };
    "Kvantum/Matugen.svg".source = ./Matugen.svg;
  };

}
