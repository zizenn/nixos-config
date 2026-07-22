{ pkgs, config, ... }:

let
  neovimRuntimePackages = with pkgs; [
    lua-language-server
    typescript-language-server
    vscode-langservers-extracted
    pyright
    clang-tools
    tree-sitter
    stylua
    prettier
    python3Packages.autopep8
    python3Packages.debugpy
  ];

  neovimRuntimeEnv = pkgs.buildEnv {
    name = "neovim-runtime-env";
    paths = neovimRuntimePackages;
  };

  neovimWrapped = pkgs.symlinkJoin {
    name = "neovim-wrapped";
    paths = [ pkgs.neovim ];
    nativeBuildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/nvim \
        --prefix PATH : ${neovimRuntimeEnv}/bin
    '';
  };
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    package = neovimWrapped;
  };

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
