{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."hyprflow/config.toml".source = ./config.toml;
}
