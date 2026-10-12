{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, lib, ... }:
    let
      colloid-sharp = pkgs.colloid-gtk-theme.override {
        colorVariants = [ "dark" ];
        tweaks = [
          "black"
          "rimless"
        ];
      };
    in
    {
      home.sessionVariables = {
        GTK_USE_PORTAL = "1";
        QT_STYLE_OVERRIDE = "kvantum";
        QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
        # Matches XCURSOR_SIZE/HYPRCURSOR_SIZE in hypr/modules/env.lua
        # and uwsm/env in hyprland.nix.
        XCURSOR_SIZE = "18";
      };

      gtk = {
        enable = true;
        theme = {
          name = "Colloid-Dark";
          package = colloid-sharp;
        };
        iconTheme = {
          name = "Papirus-Dark";
          package = pkgs.papirus-icon-theme;
        };
        cursorTheme = {
          name = "rose-pine-cursor";
          package = pkgs.rose-pine-cursor;
        };
        gtk3.extraConfig = {
          gtk-application-prefer-dark-theme = true;
          gtk-decoration-layout = "menu:";
        };
        gtk4.extraConfig = {
          gtk-application-prefer-dark-theme = true;
          gtk-decoration-layout = "menu:";
        };
      };
      # NOTE: gtk.css color files are owned by Noctalia's gtk user
      # templates (see ./noctalia/theme.toml) and must stay
      # writable — do NOT manage them here.

      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style = {
          name = "kvantum";
          package = pkgs.qt6Packages.qtstyleplugin-kvantum;
        };
      };
      home.packages = with pkgs; [
        kdePackages.qt6ct
        libsForQt5.qt5ct
        libsForQt5.qtstyleplugin-kvantum
      ];
      xdg.configFile = {
        "Kvantum/kvantum.kvconfig".source = ./qt/kvantum.kvconfig;
        # NOTE: Kvantum/Noctalia.kvconfig is rendered by Noctalia's kvantum
        # user template and must stay writable — do NOT manage it here.
        "Kvantum/Noctalia.svg".source = ./qt/Noctalia.svg;
      };
    };
}
