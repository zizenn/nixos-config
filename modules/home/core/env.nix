{ config, lib, ... }:

{
  home.sessionVariables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    VISUAL = "nvim";
    GTK_USE_PORTAL = "1";
    NSS_SSL_CBC_RANDOM_IV = "0";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
  };

  xdg.configFile."uwsm/env-hyprland".text = ''
    export XCURSOR_SIZE=24
    export HYPRCURSOR_SIZE=24
    export EDITOR=nvim
    export VISUAL=nvim
    export GTK_USE_PORTAL=1
    export NSS_SSL_CBC_RANDOM_IV=0
    export QT_STYLE_OVERRIDE=kvantum
    export QT_QPA_PLATFORMTHEME=qt6ct
  '';
}
