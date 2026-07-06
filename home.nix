{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./configs/rofi.nix
    ./configs/zsh.nix
    ./configs/kitty.nix
    ./configs/hyprland.nix
    ./configs/matugen.nix
    ./configs/wallpaper.nix
    ./configs/waybar.nix
    ./configs/neovim.nix
    ./configs/zed.nix
    ./configs/yazi.nix
    ./configs/mako.nix
    ./configs/wleave.nix
    ./configs/aerc.nix
    ./packages.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);
  };

  home.username = "zizenn";
  home.homeDirectory = "/home/zizenn";

  # ENVIRONMENT VARIABLES
  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      # feh
      "image/jpeg" = [ "feh.desktop" ];
      "image/png" = [ "feh.desktop" ];
      "image/gif" = [ "feh.desktop" ];
      "image/webp" = [ "feh.desktop" ];
      "image/bmp" = [ "feh.desktop" ];
      "image/tiff" = [ "feh.desktop" ];

      # vlc
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


  programs.zsh.enable = true;

  # CONFIGURATION
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "sakif";
        email = "zizenn@proton.me";
      };
      core = {
        editor = "nvim";
      };
    };
  };

  programs.jujutsu = {
  enable = true;
    settings = {
      user = {
        name = "sakif";
        email = "zizenn.69@gmail.com";
      };
      ui = {
        default-editor = "nvim";
      };
    };
  };

  programs.fetch = {
    enable = true;
    labelColor = "red";
    info = [
      "os"
      "kernel"
      "uptime"
    ];
    speed = 1.0;
    spin = "xy";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
      obs-vaapi
    ];
  };

  # SYSTEM
  home.stateVersion = "26.05";
}
