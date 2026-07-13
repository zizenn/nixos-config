{
  config,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./configs/shell.nix
    ./configs/git.nix
    ./configs/jujutsu.nix
    ./configs/obs.nix
    ./configs/opencode.nix
    ./configs/kitty.nix
    ./configs/hyprland.nix
    ./configs/neovim.nix
    ./configs/rofi.nix
    ./configs/waybar.nix
    ./configs/yazi.nix
    ./configs/wallpaper.nix
    ./configs/matugen.nix
    ./configs/mako.nix
    ./configs/wleave.nix
    ./configs/fastfetch.nix
    ./configs/aerc.nix
    ./configs/zed.nix
    ./configs/zen.nix
    ./configs/tmux.nix
    ./packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    VISUAL = "nvim";
    QT_QUICK_BACKEND = "software";
    QSG_RHI_BACKEND = "opengl";
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
