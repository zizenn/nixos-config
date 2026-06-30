{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      cargo
      fzf
      ripgrep
      fd
      gcc
      nodejs
    ];
  };

  # symlink your config dir into ~/.config/nvim
  xdg.configFile."nvim" = {
    source = ./nvim; # path to your config dir in your dotfiles repo
    recursive = true;
  };
}
