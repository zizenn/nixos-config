{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;
  xdg.configFile."rofi/clipboard.rasi".source = ./rofi/clipboard.rasi;
  xdg.configFile."rofi/themes/glass.rasi" = {
    source = ./rofi/glass.rasi;
    force = true;
  };
  xdg.configFile."rofi/themes/wallpaper-grid.rasi" = {
    source = ./rofi/wallpaper-grid.rasi;
    force = true;
  };

  home.file.".local/bin/cliphist-rofi-img" = {
    source = ./rofi/cliphist-rofi-img;
    executable = true;
  };
}
