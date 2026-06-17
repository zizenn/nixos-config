{ config, pkgs, ... }:

{
  home.username = "zizenn";
  home.homeDirectory = "/home/zizenn";

  # ENVIRONMENT VARIABLES

  home.sessionVariables = {
    SUDO_EDITOR = "nvim";
    EDITOR = "nvim";
    VISUAL = "nvim";
  };


  # PACKAGES

  home.packages = with pkgs; [
    git
    neovim
    zsh
  ];

  programs.git.enable = true;
  programs.zsh.enable = true;

  # Home Manager needs a version
  home.stateVersion = "26.05";
}
