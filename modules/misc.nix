{lib, ...}: {
  homeManager.modules.base = {pkgs, ...}: {
    home.sessionVariables = {
      EDITOR = "nvim";
      SUDO_EDITOR = "nvim";
      VISUAL = "nvim";
      GTK_USE_PORTAL = "1";
      NSS_SSL_CBC_RANDOM_IV = "0";
      QT_STYLE_OVERRIDE = "kvantum";
      QT_QPA_PLATFORMTHEME = lib.mkForce "qt6ct";
      XCURSOR_SIZE = "24";
    };
    home.packages = with pkgs; [
      bluetui herdr ntfs3g wiremix
    ];
    home.file = {
      ".local/bin/pkgadd" = {
        executable = true;
        text = ''
#!${pkgs.fish}/bin/fish
${builtins.readFile ./core/scripts/pkgadd}
        '';
      };
      ".local/bin/pkgdel" = {
        executable = true;
        text = ''
#!${pkgs.fish}/bin/fish
${builtins.readFile ./core/scripts/pkgdel}
        '';
      };
    };
    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "image/jpeg" = ["feh.desktop"];
        "image/png" = ["feh.desktop"];
        "image/gif" = ["feh.desktop"];
        "image/webp" = ["feh.desktop"];
        "image/bmp" = ["feh.desktop"];
        "image/tiff" = ["feh.desktop"];
        "video/x-matroska" = "vlc.desktop";
        "video/mp4" = "vlc.desktop";
        "video/webm" = "vlc.desktop";
        "video/ogg" = "vlc.desktop";
        "video/quicktime" = "vlc.desktop";
        "audio/mp3" = "vlc.desktop";
        "audio/x-flac" = "vlc.desktop";
        "audio/mpeg" = "vlc.desktop";
      };
    };
  };
}
