{ ... }:
{
  home-manager.users.zizenn =
    { pkgs, ... }:
    {
      programs.neovim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
      };
      programs.zed-editor = {
        enable = true;
        installRemoteServer = true;
      };
      home.packages = with pkgs; [
        opencode

        # nvim stuff (lsp)
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
        nixd
        nixfmt
        rust-analyzer

        # c stuff
        gnumake
        gcc
      ];
      xdg.configFile = {
        "nvim".source = ../neovim/nvim;
        "nvim".recursive = true;
      };
    };
}
