{ config, pkgs, lib, ... }:

let
  # Neovim plugin packages needed for lazy.nvim to work
  neovimPlugins = with pkgs; [
    # Core dependencies
    nodejs-20
    npm
    python3
    python3Packages.pynvim
    ripgrep
    fd
    fzf
    unzip
    curl
    git
    gnumake
    cmake
    gcc
    clang-tools
    lua-language-server
    nil
    python3Packages.ruff
    python3Packages.black
    stylua
    prettier
    prettierd
    eslint_d
    shfmt
    clang-format
    gofumpt
    rustfmt
    nixfmt
    hadolint
    jsonlint
    yamllint
    markdownlint-cli
    shellcheck
    golangci-lint
    codelldb
    delve
    bash-language-server
    vscode-langservers-extracted
    typescript-language-server
    yaml-language-server
    dockerfile-language-server-nodejs
    marksman
    vim-language-server
    gopls
    rust-analyzer
    taplo-cli
    tree-sitter-cli
  ];

in {
  home.packages = neovimPlugins;

  # Ensure required directories exist
  xdg.configFile = {
    "nvim/lua/plugins/lsp.lua".source = ./nvim/lua/plugins/lsp.lua;
    "nvim/lua/plugins/treesitter.lua".source = ./nvim/lua/plugins/treesitter.lua;
    "nvim/lua/plugins/ui.lua".source = ./nvim/lua/plugins/ui.lua;
    "nvim/lua/plugins/bufferline.lua".source = ./nvim/lua/plugins/bufferline.lua;
    "nvim/lua/plugins/noice.lua".source = ./nvim/lua/plugins/noice.lua;
    "nvim/lua/plugins/lint.lua".source = ./nvim/lua/plugins/lint.lua;
    "nvim/lua/plugins/dap.lua".source = ./nvim/lua/plugins/dap.lua;
    "nvim/lua/plugins/git.lua".source = ./nvim/lua/plugins/git.lua;
    "nvim/lua/plugins/qol.lua".source = ./nvim/lua/plugins/qol.lua;
    "nvim/lua/config/theme.lua".source = ./nvim/lua/config/theme.lua;
    "nvim/lua/config/options.lua".source = ./nvim/lua/config/options.lua;
    "nvim/lua/config/keymaps.lua".source = ./nvim/lua/config/keymaps.lua;
    "nvim/lua/config/autocmds.lua".source = ./nvim/lua/config/autocmds.lua;
    "nvim/lua/config/lazy.lua".source = ./nvim/lua/config/lazy.lua;
  };
}