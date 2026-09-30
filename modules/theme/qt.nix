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
      # NOTE: Kvantum/Noctalia.kvconfig is rendered by Noctalia's kvantum
      # user template and must stay writable — do NOT manage it here.
      "Kvantum/Noctalia.svg".source = ./qt/Noctalia.svg;
    };
  };
}
