{ config, lib, pkgs, ... }: {
  programs = {
    zsh.enable = true;
    dconf.enable = true;
    firefox.enable = true;

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

  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  environment.systemPackages = with pkgs; [
    vim
    glib
    xdg-utils
    brightnessctl
    playerctl
    cliphist
  ];

  users.users.zizenn = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "video" ];
    shell = pkgs.zsh;
  };
}
