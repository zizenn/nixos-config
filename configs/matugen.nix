{ config, pkgs, ... }:

{
  xdg.configFile = {
    "matugen/config.toml".source = ./matugen/config.toml;

    "matugen/templates/nvim-colors.jsonc".source = ./matugen/templates/nvim-colors.jsonc;
    "matugen/templates/rofi-colors.rasi".source = ./matugen/templates/rofi.rasi;
    "matugen/templates/zed-theme.json".source = ./matugen/templates/zed.json;
    "matugen/templates/kitty.conf".source = ./matugen/templates/kitty.conf;
    "matugen/templates/waybar.css".source = ./matugen/templates/waybar.css;
    "matugen/templates/obsidian.css".source = ./matugen/templates/obsidian.css;
    "matugen/templates/vesktop.css".source = ./matugen/templates/vesktop.css;
    "matugen/templates/mako.conf".source = ./matugen/templates/mako.conf;
    "matugen/templates/wleave.css".source = ./matugen/templates/wleave.css;
  };
}
