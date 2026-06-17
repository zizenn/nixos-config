{ config, pkgs, ... }:

{
  xdg.configFile = {
    "matugen/config.toml".text = ''
      [config]
      mode = "dark"
      type = "scheme-tonal-spot"
      contrast = 0.0

      [templates.kitty]
      input_path = "~/.config/matugen/templates/kitty.conf"
      output_path = ["~/.config/kitty/current-colors.conf"]
    '';

    "matugen/templates/kitty.conf".text = ''
      foreground {{colors.on_surface.default.hex}}
      background {{colors.surface.default.hex}}
      selection_foreground {{colors.on_primary_container.default.hex}}
      selection_background {{colors.primary_container.default.hex}}
      cursor {{colors.primary.default.hex}}
      cursor_text_color {{colors.on_primary.default.hex}}
      url_color {{colors.tertiary.default.hex}}
      active_tab_foreground {{colors.on_primary.default.hex}}
      active_tab_background {{colors.primary.default.hex}}
      inactive_tab_foreground {{colors.on_surface_variant.default.hex}}
      inactive_tab_background {{colors.surface_variant.default.hex}}
      color0 {{colors.surface_variant.default.hex}}
      color1 {{colors.error.default.hex}}
      color2 {{colors.primary.default.hex}}
      color3 {{colors.tertiary.default.hex}}
      color4 {{colors.secondary.default.hex}}
      color5 {{colors.primary_container.default.hex}}
      color6 {{colors.tertiary_container.default.hex}}
      color7 {{colors.on_surface.default.hex}}
      color8 {{colors.outline.default.hex}}
      color9 {{colors.on_error_container.default.hex}}
      color10 {{colors.on_primary.default.hex}}
      color11 {{colors.on_tertiary.default.hex}}
      color12 {{colors.on_secondary.default.hex}}
      color13 {{colors.on_primary_container.default.hex}}
      color14 {{colors.on_tertiary_container.default.hex}}
      color15 {{colors.on_surface_variant.default.hex}}
    '';
  };
}
