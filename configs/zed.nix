{ config, pkgs, ... }:

{
  xdg.configFile = {
    "zed/settings.json".text = ''
      // Zed settings
      {
        "icon_theme": "Zed (Default)",
        "vim_mode": true,
        "session": {
          "trust_all_worktrees": true
        },
        "ui_font_size": 16,
        "buffer_font_size": 15,
        "theme": {
          "mode": "dark",
          "dark": "Matugen Dark",
          "light": "Matugen Dark"
        }
      }
    '';

    # ensure themes directory exists for matugen to write into
    "zed/themes/.keep".text = "";
  };
}
