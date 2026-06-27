{
  description = "Neovim configuration — packages for LSP, DAP, and tooling";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
      in
      {
        packages = {
          # LSP servers
          typescript-language-server = pkgs.typescript-language-server;
          vscode-langservers-extracted = pkgs.vscode-langservers-extracted; # html, css, json

          # DAP adapters
          js-debug-adapter = pkgs.vscode-js-debug;
          debugpy = pkgs.python3Packages.debugpy;

          # Formatters / linters
          stylua = pkgs.stylua;
          selene = pkgs.selene;
          prettierd = pkgs.prettierd;

          # Wrapped neovim with everything baked in
          neovim = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped {
            extraMakeWrapperArgs = ''--suffix PATH : ${pkgs.lib.makeBinPath [
              self.packages.${system}.typescript-language-server
              self.packages.${system}.vscode-langservers-extracted
              self.packages.${system}.js-debug-adapter
              self.packages.${system}.debugpy
              self.packages.${system}.stylua
              self.packages.${system}.selene
              self.packages.${system}.prettierd
              pkgs.clang-tools
              pkgs.nixd
              pkgs.lua-language-server
              pkgs.pyright
              pkgs.bash-language-server
              pkgs.yaml-language-server
              pkgs.marksman
              pkgs.gdb
              pkgs.lldb
              pkgs.nodejs
              pkgs.python3
              pkgs.nixfmt-rfc-style
              pkgs.shellcheck
              pkgs.shfmt
              pkgs.lazygit
              pkgs.fzf
              pkgs.ripgrep
              pkgs.fd
            ]}'';

            wrapperArgsStr = ''
              --suffix NVIM_APPNAME : nvim
            '';
          };

          default = self.packages.${system}.neovim;
        };

        devShells.default = pkgs.mkShell {
          name = "neovim-config";
          packages = builtins.attrValues self.packages.${system};
          shellHook = ''
            echo "󰢱  Neovim config dev shell"
            echo "  stylua   — format Lua files"
            echo "  selene   — lint Lua files"
            echo "  prettierd — format JS/TS/CSS/HTML"
          '';
        };
      }
    );
}
