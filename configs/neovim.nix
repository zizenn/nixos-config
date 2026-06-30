{ pkgs, config, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      nil               # nix lsp
      clang-tools       # clangd, clang-format
      pyright           # python lsp
      vscode-langservers-extracted  # html, css, json lsp
      typescript-language-server    # js/ts lsp
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
