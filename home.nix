# /etc/nixos/home.nix
{ config, pkgs, ... }: {

  # Basic user environment details
  home.username = "zizenn";
  home.homeDirectory = "/home/zizenn";
  home.stateVersion = "25.05"; # Match your current NixOS version

  # Declare user-specific packages
  home.packages = with pkgs; [
    neovim
    git
    tmux
  ];

  # Manage dotfiles and program configs directly in Nix
  programs.git = {
    enable = true;
    userName = "sakif";
    userEmail = "zizenn@proton.me";
    core.editor = "nvim";
  };

  programs.zsh.enable = true;
}

