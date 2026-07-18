{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."rofi/config.rasi".source = ./config.rasi;
  xdg.configFile."rofi/clipboard.rasi".source = ./clipboard.rasi;
  xdg.configFile."rofi/themes/glass.rasi" = {
    source = ./glass.rasi;
    force = true;
  };
  xdg.configFile."rofi/themes/wallpaper-grid.rasi" = {
    source = ./wallpaper-grid.rasi;
    force = true;
  };

  home.file.".local/bin/cliphist-rofi-img" = {
    source = ./cliphist-rofi-img;
    executable = true;
  };
}
