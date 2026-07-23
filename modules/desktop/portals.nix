{lib, ...}: {
  nixos.modules.base = {pkgs, ...}: {
    services.xserver.enable = true;
    xdg.portal = {
      enable = true;
      extraPortals = [
        pkgs.xdg-desktop-portal-gtk
        pkgs.xdg-desktop-portal-gnome
        pkgs.xdg-desktop-portal-xapp
      ];
      config.common.default = ["gtk"];
    };
  };
}
