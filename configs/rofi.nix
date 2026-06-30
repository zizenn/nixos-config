{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."rofi/config.rasi".source = ./rofi/config.rasi;
}
