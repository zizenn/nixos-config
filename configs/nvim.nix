{ config, pkgs, ... }:

{

  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      cargo
      rustc
      fzf
      ripgrep
      fd
      gcc
      nodejs
    ];
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
