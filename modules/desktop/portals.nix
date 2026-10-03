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
      # "*" defers to per-desktop preferences — niri ships niri-portals.conf
      # (default=gnome;gtk) so ScreenCast goes to the GNOME portal for
      # PipeWire capture. Forcing ["gtk"] here would shadow that and break
      # OBS window/monitor capture.
      config.common.default = "*";
    };
  };
}
