{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;
  };

  xdg.configFile."yazi" = {
    source = ./yazi;
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
