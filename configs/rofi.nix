{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;
  xdg.configFile."rofi/clipboard.rasi".source = ./rofi/clipboard.rasi;

  home.file.".local/bin/cliphist-rofi-img" = {
    source = ./rofi/cliphist-rofi-img;
    executable = true;
  };
}
