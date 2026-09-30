{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: let
    colloid-sharp = pkgs.colloid-gtk-theme.override {
      colorVariants = ["dark"];
      tweaks = ["black" "rimless"];
    };
  in {
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
    # templates (see ../theme/noctalia/theme.toml) and must stay
    # writable — do NOT manage them here.
  };
}
