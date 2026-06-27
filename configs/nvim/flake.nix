{
  description = "Neovim configuration with lazy.nvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, neovim-nightly-overlay, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config = { allowUnfree = true; };
      overlays = [ neovim-nightly-overlay.overlays.default ];
    };

    neovimPackages = with pkgs; [
      # Core dependencies
      nodejs_22
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
      gofumpt
      rustfmt
      nixfmt
      hadolint
      yamllint
      shellcheck
      golangci-lint
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
      taplo
    ];

  in {
    packages.${system} = {
      default = pkgs.neovim.override {
        vimAlias = true;
        viAlias = true;
        withNodeJs = false;
        withPython3 = false;
        withRuby = false;
        extraPackages = neovimPackages;
      };
    };

    devShells.${system}.default = pkgs.mkShell {
      buildInputs = neovimPackages;
    };

    apps.${system}.neovim = {
      type = "app";
      program = "${pkgs.neovim}/bin/nvim";
    };
  };
}