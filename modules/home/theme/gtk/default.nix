{ config, pkgs, ... }:

let
  colloid-sharp = pkgs.colloid-gtk-theme.override {
    colorVariants = [ "dark" ];
    tweaks = [ "black" "rimless" ];
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

  # pre-seeded fallbacks — overwritten by matugen/theme-kanagawa
  home.file = {
    ".config/gtk-3.0/gtk.css" = {
      source = ./gtk3-override.css;
      force = true;
    };
    ".config/gtk-4.0/gtk.css" = {
      source = ./gtk4-override.css;
      force = true;
    };
  };
}
