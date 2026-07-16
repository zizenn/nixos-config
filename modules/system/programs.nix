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
    nix-ld.enable = true;
    ccache.enable = true;

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
    man.generateCaches = true;
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
