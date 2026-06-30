{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # LSP servers, formatters, linters you need
      lua-language-server
      nil # nix lsp
      ripgrep
      fd
      gcc # for treesitter compilation
      nodejs # many LSPs need this
    ];
  };

  # symlink your config dir into ~/.config/nvim
  xdg.configFile."nvim" = {
    source = ./nvim; # path to your config dir in your dotfiles repo
    recursive = true;
  };
}
