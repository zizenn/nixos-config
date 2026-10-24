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
