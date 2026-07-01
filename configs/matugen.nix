{ config, pkgs, ... }:

{
  xdg.configFile = {
    "matugen/config.toml".source = ./matugen/config.toml;

    "matugen/templates/nvim.jsonc".source = ./matugen/templates/nvim.jsonc;
    "matugen/templates/rofi-colors.rasi".source = ./matugen/templates/rofi.rasi;
    "matugen/templates/zed-theme.json".source = ./matugen/templates/zed.json;
    "matugen/templates/kitty.conf".source = ./matugen/templates/kitty.conf;
    "matugen/templates/waylandar-theme.qml".source = ./matugen/templates/waylandar.qml;
    "matugen/templates/waybar.css".source = ./matugen/templates/waybar.css;
    "matugen/templates/obsidian.css".source = ./matugen/templates/obsidian.css;
    "matugen/templates/vesktop.css".source = ./matugen/templates/vesktop.css;
  };
}
