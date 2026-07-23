{ pkgs, ... }:

{
  home.packages = with pkgs; [ ripdrag ];

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    plugins = {
      drag = pkgs.yaziPlugins.drag;
      ouch = pkgs.yaziPlugins.ouch;
    };

    settings = {
      mgr = {
        ratio = [ 1 3 4 ];
        sort_by = "natural";
        sort_sensitive = false;
        sort_reverse = false;
        sort_dir_first = true;
        show_hidden = false;
      };
      input = {
        cursor_blink = true;
      };
    };

    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = [ "<C-d>" ];
            run = "plugin drag";
            desc = "Drag selected files out of Yazi via ripdrag";
          }
        ];
      };
    };
  };

  xdg.desktopEntries.yazi = {
    name = "yazi";
    exec = "kitty --class yazi-float -e yazi %u";
    terminal = false;
    mimeType = [ "inode/directory" ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = [ "yazi.desktop" ];
    };
  };
}
