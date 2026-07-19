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
        libx11
        libxcomposite
        libxdamage
        libxext
        libxfixes
        libxrandr
        libxrender
        libxtst
        libxcb
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
    wget
    xdg-utils
    brightnessctl
    playerctl
    cliphist
    man-pages
    steam-run
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
