{ pkgs, lib, config, inputs, ... }: {
  name = "cpp-dev";

  packages = [
    pkgs.ccache
    pkgs.gnumake
    pkgs.llvmPackages_latest.clang
  ];

  enterShell = ''
    mkdir -p .devenv/ccache-links
    ln -sf ${pkgs.ccache}/bin/ccache .devenv/ccache-links/clang
    ln -sf ${pkgs.ccache}/bin/ccache .devenv/ccache-links/clang++
    export PATH="$PWD/.devenv/ccache-links:$PATH"
    export CCACHE_DIR="$HOME/.cache/ccache"
    mkdir -p "$CCACHE_DIR"
    ccache -M 10G
  '';
}
