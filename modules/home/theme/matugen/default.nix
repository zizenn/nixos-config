{ config, pkgs, ... }:

{
  xdg.configFile = {
    "matugen/config.toml".source = ./config.toml;

    "matugen/templates/nvim-colors.json".source = ./templates/nvim-colors.json;
    "matugen/templates/rofi-colors.rasi".source = ./templates/rofi.rasi;
    "matugen/templates/zed-theme.json".source = ./templates/zed.json;
    "matugen/templates/kitty.conf".source = ./templates/kitty.conf;
    "matugen/templates/waybar.css".source = ./templates/waybar.css;
    "matugen/templates/obsidian.css".source = ./templates/obsidian.css;
    "matugen/templates/vesktop.css".source = ./templates/vesktop.css;
    "matugen/templates/mako.conf".source = ./templates/mako.conf;
    "matugen/templates/wleave.css".source = ./templates/wleave.css;
    "matugen/templates/hyprlock.conf".source = ./templates/hyprlock.conf;
    "matugen/templates/sddm.conf".source = ./templates/sddm.conf;
    "matugen/templates/gtk.css".source = ./templates/gtk.css;
    "matugen/templates/gtk4.css".source = ./templates/gtk4.css;
    "matugen/templates/kvantum/Matugen.kvconfig".source = ./templates/kvantum/Matugen.kvconfig;
    "matugen/templates/kvantum/Matugen.svg".source = ./templates/kvantum/Matugen.svg;
    "matugen/templates/zennotes.css".source = ./templates/zennotes.css;
  };
}
