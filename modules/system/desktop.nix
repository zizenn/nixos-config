{ config, lib, pkgs, ... }: let
  sddm-theme-dir = "/var/lib/sddm-themes/where_is_my_sddm_theme";
in {
  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = sddm-theme-dir;
    extraPackages = [ pkgs.where-is-my-sddm-theme ];
  };

  systemd.services.copy-sddm-theme = {
    description = "Copy SDDM theme to writable location for matugen";
    wantedBy = [ "display-manager.service" ];
    before = [ "display-manager.service" ];
    script = ''
      if [ ! -d "${sddm-theme-dir}" ]; then
        install -d -m 0755 "$(dirname ${sddm-theme-dir})"
        cp -a ${pkgs.where-is-my-sddm-theme}/share/sddm/themes/where_is_my_sddm_theme ${sddm-theme-dir}
      fi
    '';
    serviceConfig.Type = "oneshot";
    serviceConfig.RemainAfterExit = true;
  };

  programs.skwd-wall.enable = true;

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

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    NSS_SSL_CBC_RANDOM_IV = "0";
  };
}
