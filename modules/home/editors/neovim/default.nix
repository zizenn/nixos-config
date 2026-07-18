{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

  };

  # symlink your config dir into ~/.config/nvim
  xdg.configFile."nvim" = {
    source = ./nvim; # path to your config dir in your dotfiles repo
    recursive = true;
  };
}
