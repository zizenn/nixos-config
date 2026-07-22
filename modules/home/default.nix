{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./shell/shell.nix
    ./dev/git.nix
    ./dev/jujutsu.nix
    ./apps/obs.nix
    ./editors/opencode.nix
    ./desktop/kitty.nix
    ./desktop/niri
    ./editors/neovim
    ./desktop/rofi
    ./desktop/waybar
    ./apps/yazi
    ./desktop/wallpaper.nix
    ./theme/matugen
    ./theme/matugen/kanagawa-dragon.nix
    ./desktop/mako.nix
    ./desktop/wleave
    ./theme/fastfetch
    ./mail/aerc
    ./editors/zed
    ./theme/gtk
    ./theme/qt
    ./core/scripts
    ./core/env.nix
    ./packages.nix
  ];

  programs.man.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/jpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/gif" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
      "image/bmp" = [ "feh.desktop" ];
      "image/tiff" = [ "feh.desktop" ];
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
}
