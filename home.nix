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
    yazi
    awww
    fzf
    waybar
  ];

  programs.git.enable = true;
  programs.zsh.enable = true;

  # CONFIGURATION
  xdg.configFile."nvim" = {
    source = /home/zizenn/dotfiles/nvim;
    recursive = true; # This ensures all subfolders are linked
  };

  xdg.configFile."hypr" = {
    source = /home/zizenn/dotfiles/hyprland;
    recursive = true;
  };

  # SYSTEM
  home.stateVersion = "26.05";
}
