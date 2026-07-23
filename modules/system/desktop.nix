{ config, lib, pkgs, ... }: {
  services.xserver.enable = true;

  services.displayManager.ly = {
    enable = true;
  };

  programs.niri = {
    enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-xapp
    ];
    config.common.default = [ "gtk" ];
  };
}
