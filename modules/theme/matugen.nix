{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    home.packages = with pkgs; [matugen];
    xdg.configFile = {
      "matugen/config.toml".source = ./matugen/config.toml;
      "matugen/templates/nvim-colors.json".source = ./matugen/templates/nvim-colors.json;
      "matugen/templates/rofi-colors.rasi".source = ./matugen/templates/rofi.rasi;
      "matugen/templates/zed-theme.json".source = ./matugen/templates/zed.json;
      "matugen/templates/kitty.conf".source = ./matugen/templates/kitty.conf;
      "matugen/templates/waybar.css".source = ./matugen/templates/waybar.css;
      "matugen/templates/obsidian.css".source = ./matugen/templates/obsidian.css;
      "matugen/templates/vesktop.css".source = ./matugen/templates/vesktop.css;
      "matugen/templates/mako.conf".source = ./matugen/templates/mako.conf;
      "matugen/templates/wleave.css".source = ./matugen/templates/wleave.css;
      "matugen/templates/hyprlock.conf".source = ./matugen/templates/hyprlock.conf;
      "matugen/templates/gtk.css".source = ./matugen/templates/gtk.css;
      "matugen/templates/gtk4.css".source = ./matugen/templates/gtk4.css;
      "matugen/templates/starship.toml".source = ./matugen/templates/starship.toml;
      "matugen/templates/kvantum/Matugen.kvconfig".source = ./matugen/templates/kvantum/Matugen.kvconfig;
      "matugen/templates/kvantum/Matugen.svg".source = ./matugen/templates/kvantum/Matugen.svg;
    };
  };
}
