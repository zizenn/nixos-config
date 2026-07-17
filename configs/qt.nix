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
    "Kvantum/kvantum.kvconfig".source = ./qt/kvantum.kvconfig;
    "Kvantum/Matugen.kvconfig" = {
      source = ./qt/Matugen.kvconfig;
      force = true;
    };
    "Kvantum/Matugen.svg".source = ./qt/Matugen.svg;
  };

  home.sessionVariables = {
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
  };
}
