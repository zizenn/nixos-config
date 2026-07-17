{ config, pkgs, ... }:

{
  home.file = {
    ".local/bin/theme-kanagawa" = {
      executable = true;
      text = ''
        #!${pkgs.fish}/bin/fish
        ${builtins.readFile ../scripts/theme-kanagawa}
      '';
    };

    ".config/matugen/kanagawa-dragon/kitty.conf".source = ./kanagawa-dragon/kitty.conf;
    ".config/matugen/kanagawa-dragon/nvim-colors.json".source = ./kanagawa-dragon/nvim-colors.json;
    ".config/matugen/kanagawa-dragon/rofi-colors.rasi".source = ./kanagawa-dragon/rofi-colors.rasi;
    ".config/matugen/kanagawa-dragon/zed-theme.json".source = ./kanagawa-dragon/zed-theme.json;
    ".config/matugen/kanagawa-dragon/waybar.css".source = ./kanagawa-dragon/waybar.css;
    ".config/matugen/kanagawa-dragon/mako.conf".source = ./kanagawa-dragon/mako.conf;
    ".config/matugen/kanagawa-dragon/wleave.css".source = ./kanagawa-dragon/wleave.css;
    ".config/matugen/kanagawa-dragon/hyprlock.conf".source = ./kanagawa-dragon/hyprlock.conf;
    ".config/matugen/kanagawa-dragon/gtk.css".source = ./kanagawa-dragon/gtk.css;
    ".config/matugen/kanagawa-dragon/gtk4.css".source = ./kanagawa-dragon/gtk4.css;
    ".config/matugen/kanagawa-dragon/obsidian.css".source = ./kanagawa-dragon/obsidian.css;
    ".config/matugen/kanagawa-dragon/vesktop.css".source = ./kanagawa-dragon/vesktop.css;
    ".config/matugen/kanagawa-dragon/kvantum/Matugen.kvconfig".source = ./kanagawa-dragon/kvantum/Matugen.kvconfig;
    ".config/matugen/kanagawa-dragon/kvantum/Matugen.svg".source = ./kanagawa-dragon/kvantum/Matugen.svg;
  };
}
