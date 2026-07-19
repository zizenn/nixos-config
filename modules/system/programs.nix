{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs = {
    fish.enable = true;
    dconf.enable = true;
    firefox.enable = true;
    ccache.enable = true;
    ssh.setXAuthLocation = true;

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        # Core standard dependencies
        stdenv.cc.cc
        glib
        fuse

        # Graphical/Electron stack
        gtk3
        nss
        nspr
        alsa-lib
        atk
        cairo
        pango
        cups
        dbus
        expat
        libdrm
        mesa
        libxkbcommon

        # X11 Windowing requirements
        xorg.libX11
        xorg.libXcomposite
        xorg.libXdamage
        xorg.libXext
        xorg.libXfixes
        xorg.libXrandr
        xorg.libXrender
        xorg.libXtst
        xorg.libxcb
      ];
    };

    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
      flake = "/home/zizenn/nixos";
    };

    localsend = {
      enable = true;
      openFirewall = true;
    };
  };

  # for man pages
  documentation = {
    enable = true;
    dev.enable = true;
    man.cache.enable = true;
  };

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  environment.systemPackages = with pkgs; [
    vim
    tmux
    wget
    glib
    xdg-utils
    brightnessctl
    playerctl
    cliphist
    man-pages
  ];

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
      "video"
    ];
    shell = pkgs.fish;
  };
}
