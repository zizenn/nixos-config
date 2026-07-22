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

  nvim = pkgs.writeShellScriptBin "nvim" ''
    export PATH="${neovimRuntimeEnv}/bin''${PATH:+:$PATH}"
    exec ${pkgs.neovim}/bin/nvim "$@"
  '';
in {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = [ nvim ];

  xdg.configFile."nvim" = {
    source = ./nvim;
    recursive = true;
  };
}
