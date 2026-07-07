{ config, lib, pkgs, ... }: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-xapp
    ];
    config.common.default = [ "xapp" ];
  };

  users.users.greeter.extraGroups = [ "video" ];

  services.sysc-greet = {
    enable = true;
    compositor = "hyprland";
    hyprlandPackage = pkgs.hyprland;
    settings = {
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "zizenn";
      };
    };
  };

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    LIBVA_DRIVER_NAME = "radeonsi";
    NSS_SSL_CBC_RANDOM_IV = "0";
  };
}
