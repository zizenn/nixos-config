{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true; # Change to enableZshIntegration if using zsh
  };

  xdg.desktopEntries.yazi = {
    name = "yazi";
    exec = "kitty --class yazi-float -e yazi %u"; # Replace 'kitty' with your preferred terminal
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
