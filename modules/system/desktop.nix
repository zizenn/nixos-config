{ config, lib, pkgs, ... }: let
  greeter-compositor-debug = pkgs.writeShellScript "greeter-compositor" ''
    LOG=/tmp/greeter-compositor.log
    echo "=== $(date -Isec) Starting greeter compositor ===" >> $LOG
    echo "USER=$USER HOME=$HOME" >> $LOG
    echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR" >> $LOG
    env >> $LOG
    echo "--- Executing: ${pkgs.hyprland}/bin/start-hyprland -- -c /etc/greetd/hyprland-greeter-config.conf" >> $LOG
    ${pkgs.hyprland}/bin/start-hyprland -- -c /etc/greetd/hyprland-greeter-config.conf >> $LOG 2>&1
    EC=$?
    echo "--- Exit code: $EC" >> $LOG
    echo "=== $(date -Isec) Finished ===" >> $LOG
    exit $EC
  '';
in {
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

  users.users.greeter.extraGroups = [ "video" "input" ];

  services.sysc-greet = {
    enable = true;
    compositor = "hyprland";
    hyprlandPackage = pkgs.hyprland;
    compositorCommand = "${greeter-compositor-debug}";
    settings = {
      initial_session = {
        command = "${pkgs.uwsm}/bin/uwsm start -e -D Hyprland hyprland.desktop";
        user = "zizenn";
      };
    };
  };

  systemd.services.greetd = {
    after = [ "dev-dri.device" ];
    wants = [ "dev-dri.device" ];
  };

  environment.sessionVariables = {
    GTK_USE_PORTAL = "1";
    LIBVA_DRIVER_NAME = "radeonsi";
    NSS_SSL_CBC_RANDOM_IV = "0";
  };
}
