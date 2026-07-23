{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    qt = {
      enable = true;
      platformTheme.name = "qtct";
      style = {
        name = "kvantum";
        package = pkgs.qt6Packages.qtstyleplugin-kvantum;
      };
    };
    home.packages = with pkgs; [
      kdePackages.qt6ct
      libsForQt5.qt5ct
      libsForQt5.qtstyleplugin-kvantum
    ];
    xdg.configFile = {
      "Kvantum/kvantum.kvconfig".source = ./qt/kvantum.kvconfig;
      "Kvantum/Matugen.kvconfig" = {
        source = ./qt/Matugen.kvconfig;
        force = true;
      };
      "Kvantum/Matugen.svg".source = ./qt/Matugen.svg;
    };
  };
}
