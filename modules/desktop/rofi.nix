{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    xdg.configFile = {
      "rofi/config.rasi".source = ./rofi/config.rasi;
      "rofi/clipboard.rasi".source = ./rofi/clipboard.rasi;
      "rofi/themes/glass.rasi" = {
        source = ./rofi/glass.rasi;
        force = true;
      };
      "rofi/themes/wallpaper-grid.rasi" = {
        source = ./rofi/wallpaper-grid.rasi;
        force = true;
      };
    };
    home.file.".local/bin/cliphist-rofi-img" = {
      source = ./rofi/cliphist-rofi-img;
      executable = true;
    };
    home.packages = with pkgs; [rofi];
  };
}
