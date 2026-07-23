{ pkgs, lib, ... }:

{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = lib.importTOML ./config/yazi.toml;
    theme = lib.importTOML ./config/theme.toml;

    keymap = {
      manager = {
        prepend_keymap = [
          {
            on = [ "<C-d>" ];
            run = "shell '$HOME/.config/yazi/drag.sh %s'";
            desc = "Drag selected files out with ripdrag";
          }
        ];
      };
    };

    extraPackages = with pkgs; [ ripdrag ];
  };

  home.packages = with pkgs; [ ripdrag ];

  xdg.configFile."yazi/drag.sh" = {
    source = ./config/drag.sh;
    executable = true;
    force = true;
  };

  xdg.configFile."yazi/plugins/ouch.yazi" = {
    source = ./config/plugins/ouch.yazi;
    recursive = true;
    force = true;
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
