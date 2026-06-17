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
    matugen
  ];

  programs.git.enable = true;
  programs.zsh.enable = true;

  # CONFIGURATION
    programs.git = {
    enable = true;
    extraConfig = {
      core.editor = "nvim";
    };
  };

  xdg.configFile."nvim" = {
    source = /home/zizenn/dotfiles/nvim;
    recursive = true;
  };

  xdg.configFile."hypr" = {
    source = /home/zizenn/dotfiles/hyprland;
    recursive = true;
  };

  # SYSTEM
  home.stateVersion = "26.05";
}
