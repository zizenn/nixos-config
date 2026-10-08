{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
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
          include = "themes/noctalia.conf";
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
      # NOTE: kitty colors come from Noctalia's builtin kitty template
      # (~/.config/kitty/themes/noctalia.conf, included above) — do NOT
      # manage a colors file here, the template output must stay writable.
    };
}
