{
  config,
  pkgs,
  ...
}:

{
  xdg.configFile."hyprflow/config.toml".source = ./hyprflow/config.toml;
}
