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
    opencode
    mako
    ripgrep
    python3
    ntfs3g
  ];

  programs.zsh.enable = true;

  # CONFIGURATION
    programs.git = {
    enable = true;
    userName = "sakif";
    userEmail = "zizenn@proton.me";
    extraConfig = {
      core.editor = "nvim";
    };
  };

  # SYSTEM
  home.stateVersion = "26.05";
}
