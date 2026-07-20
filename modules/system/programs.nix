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

    # minecraft
    modrinth-app
    temurin-bin-21 # Required for Minecraft 1.20.5 and newer
    temurin-bin-17 # Required for Minecraft 1.18 to 1.20.4
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
