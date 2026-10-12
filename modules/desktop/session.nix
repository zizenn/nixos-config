{ pkgs, ... }:
{
  services.displayManager.ly.enable = true;

  programs.dconf.enable = true;

  services.xserver.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
      pkgs.xdg-desktop-portal-xapp
    ];
    # "*" defers to per-desktop preferences — Hyprland ships
    # hyprland-portals.conf so ScreenCast goes to the Hyprland portal for
    # PipeWire capture. Forcing ["gtk"] here would shadow that and break
    # OBS window/monitor capture.
    config.common.default = "*";
  };

  services.logind.settings = {
    Login = {
      HandlePowerKey = "ignore";
      HandleLidSwitch = "suspend";
      HandleLidSwitchExternalPower = "lock";
      LidSwitchIgnoreInhibited = "no";
    };
  };
}
