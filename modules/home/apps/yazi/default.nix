{ pkgs, lib, ... }:

let
  inherit (lib) importTOML;
in
{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = importTOML ./config/yazi.toml;
    keymap = importTOML ./config/keymap.toml;
    theme = importTOML ./config/theme.toml;

    extraPackages = [ ripdrag ];
  };

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
