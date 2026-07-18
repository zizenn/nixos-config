{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./modules/home/shell.nix
    ./modules/home/git.nix
    ./modules/home/jujutsu.nix
    ./modules/home/obs.nix
    ./modules/home/opencode.nix
    ./modules/home/kitty.nix
    ./modules/home/hyprland.nix
    ./modules/home/neovim.nix
    ./modules/home/rofi.nix
    ./modules/home/waybar.nix
    ./modules/home/yazi.nix
    ./modules/home/wallpaper.nix
    ./modules/home/matugen.nix
    ./modules/home/matugen/kanagawa-dragon.nix
    ./modules/home/mako.nix
    ./modules/home/wleave.nix
    ./modules/home/hyprflow.nix
    ./modules/home/fastfetch.nix
    ./modules/home/aerc.nix
    ./modules/home/zed.nix
    ./modules/home/zennotes.nix
    ./modules/home/tmux.nix
    ./modules/home/gtk.nix
    ./modules/home/qt.nix
    ./modules/home/scripts.nix
    ./modules/home/env.nix
    ./packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

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
