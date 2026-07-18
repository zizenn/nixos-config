{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    ./modules/home/shell/shell.nix
    ./modules/home/dev/git.nix
    ./modules/home/dev/jujutsu.nix
    ./modules/home/apps/obs.nix
    ./modules/home/editors/opencode.nix
    ./modules/home/desktop/kitty.nix
    ./modules/home/desktop/hyprland
    ./modules/home/editors/neovim
    ./modules/home/desktop/rofi
    ./modules/home/desktop/waybar
    ./modules/home/apps/yazi
    ./modules/home/desktop/wallpaper.nix
    ./modules/home/theme/matugen
    ./modules/home/theme/matugen/kanagawa-dragon.nix
    ./modules/home/desktop/mako.nix
    ./modules/home/desktop/wleave
    ./modules/home/desktop/hyprflow
    ./modules/home/theme/fastfetch
    ./modules/home/mail/aerc
    ./modules/home/editors/zed
    ./modules/home/apps/zennotes.nix
    ./modules/home/shell/tmux.nix
    ./modules/home/theme/gtk
    ./modules/home/theme/qt
    ./modules/home/core/scripts
    ./modules/home/core/env.nix
    ./packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

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
