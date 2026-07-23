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
    XCURSOR_SIZE = "24";
    AMD_VULKAN_ICD = "RADV";
    mesa_glthread = "true";
  };
}
