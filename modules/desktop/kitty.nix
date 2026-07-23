{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    programs.kitty = {
      enable = true;
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 11.0;
      };
      settings = {
        shell = "fish";
        enable_audio_bell = false;
        window_padding_width = 25;
        cursor_trail = 1;
        hide_window_decorations = true;
        confirm_os_window_close = 0;
        allow_remote_control = "socket-only";
        listen_on = "unix:/tmp/kitty-zizenn";
        include = "current-colors.conf";
        enabled_layouts = "tall,splits,stack";
        active_border_color = "#11111b";
        inactive_border_color = "#11111b";
      };
      keybindings = {
        "ctrl+shift+enter" = "launch --location=vsplit";
        "ctrl+left" = "neighboring_window left";
        "ctrl+right" = "neighboring_window right";
        "ctrl+up" = "neighboring_window up";
        "ctrl+down" = "neighboring_window down";
      };
    };
    xdg.configFile.".config/kitty/current-colors.conf".text = ''
      foreground #cdd6f4
      background #1e1e2e
      selection_foreground #11111b
      selection_background #f5c2e7
      cursor #f5c2e7
      cursor_text_color #1e1e2e
      color0 #45475a
      color1 #f38ba8
      color2 #a6e3a1
      color3 #f9e2af
      color4 #89b4fa
      color5 #f5c2e7
      color6 #94e2d5
      color7 #bac2de
      color8 #585b70
      color9 #f38ba8
      color10 #a6e3a1
      color11 #f9e2af
      color12 #89b4fa
      color13 #f5c2e7
      color14 #94e2d5
      color15 #a6adc8
    '';
  };
}
